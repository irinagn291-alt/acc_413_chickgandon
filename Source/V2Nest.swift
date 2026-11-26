import Foundation
import SwiftUI
import Combine
import WidgetKit
import UserNotifications
import EventKit

@MainActor final class V2Nest:ObservableObject {
 @Published var z:[H7Row] = []
 @Published var note:String? = nil
 @Published var cloud:String = h7("Stored on this device")
 @Published var busy=false
 @Published var notices=false
 @Published var syncOn:Bool { didSet { UserDefaults.standard.set(syncOn,forKey:"cloud-on") } }
 private let ek=EKEventStore()
 private var later:Task<Void,Never>?
 private let file:URL
 init() {
  syncOn=UserDefaults.standard.bool(forKey:"cloud-on")
  let base=FileManager.default.urls(for:.applicationSupportDirectory,in:.userDomainMask)[0]
  file=base.appendingPathComponent("pasture-records.json")
  do {
   try FileManager.default.createDirectory(at:base,withIntermediateDirectories:true)
   if FileManager.default.fileExists(atPath:file.path) { z=try JSONDecoder().decode(H7Box.self,from:Data(contentsOf:file)) .rows }
  } catch {
   if FileManager.default.fileExists(atPath:file.path) {try? FileManager.default.copyItem(at:file,to:file.deletingLastPathComponent().appendingPathComponent("unreadable-"+UUID().uuidString+".json"))}
   note=h7("Could not read the local journal. Your file was kept.")
  }
  Task { await refreshNotices(); if syncOn { await sync() } }
 }
 func put(_ row:H7Row) {
  var a=row; a.u=Date()
  var next=z; if let i=next.firstIndex(where:{$0.id == a.id}) {next[i]=a} else {next.append(a)}
  persist(next)
 }
 func erase(_ row:H7Row) { var r=row; r.gone=true; r.n=""; r.b=""; r.q=""; r.p=nil; r.v=0; r.d=Date(timeIntervalSince1970:0); r.repeatDays=0; r.done=false; put(r); removeEK(row); UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers:[r.id]) }
 func persist(_ next:[H7Row], schedule:Bool=true) {
  do {
   let d=try JSONEncoder().encode(H7Box(rows:next))
   try d.write(to:file,options:[.atomic,.completeFileProtectionUntilFirstUserAuthentication])
   z=next
   if let base=FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:h7G) {
    let small=next.map{ r -> H7Row in var q=r;q.p=nil;return q }
    try JSONEncoder().encode(H7Box(rows:small)).write(to:base.appendingPathComponent("yard.json"),options:.atomic)
    WidgetCenter.shared.reloadAllTimelines()
   }
   Task { await reschedule() }
   if schedule && syncOn { later?.cancel();later=Task { try? await Task.sleep(nanoseconds:2_000_000_000); if !Task.isCancelled {await sync()} } }
  } catch {note=h7("Could not save. Please check available device storage.")}
 }
 func finish(_ row:H7Row) {
  var r=row; r.done=true; put(r)
  if let id=UserDefaults.standard.string(forKey:"ek-"+r.id),let rem=ek.calendarItem(withIdentifier:id) as? EKReminder {rem.isCompleted=true;try? ek.save(rem,commit:true)}
  if r.repeatDays > 0 {
   var next=r;next.id=UUID().uuidString;next.done=false
   var due=Calendar.current.date(byAdding:.day,value:r.repeatDays,to:r.d)!
   while due <= Date() { due=Calendar.current.date(byAdding:.day,value:r.repeatDays,to:due)! }
   next.d=due;put(next)
  }
 }
 func refreshNotices() async {
  let status=await UNUserNotificationCenter.current().notificationSettings()
  notices=status.authorizationStatus == .authorized || status.authorizationStatus == .provisional
 }
 func enableNotices() async {
  do { notices=try await UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.badge,.sound]); if !notices { note=h7("Notifications are off. Care stays in the app; you can enable alerts in Settings.") };await reschedule() }
  catch { note=h7("Notifications are unavailable. Care stays saved locally.") }
 }
 func reschedule() async {
  let c=UNUserNotificationCenter.current();c.removeAllPendingNotificationRequests()
  guard notices else{return}
  for r in H7Math.active(z,"care").filter({!$0.done && $0.d > Date()}).sorted(by:{$0.d < $1.d}).prefix(60) {
   let content=UNMutableNotificationContent();content.title=r.n;content.body=h7("Your flock care is due.");content.sound = .default
   let comps=Calendar.current.dateComponents([.year,.month,.day,.hour,.minute],from:r.d)
   try? await c.add(UNNotificationRequest(identifier:r.id,content:content,trigger:UNCalendarNotificationTrigger(dateMatching:comps,repeats:false)))
  }
 }
 func exportEK(_ r:H7Row) async {
  do {
   guard try await ek.requestFullAccessToReminders() else {note=h7("Reminders access was declined. Your care schedule remains available here.");return}
   guard let calendar=ek.defaultCalendarForNewReminders() else {note=h7("Create a list in Apple Reminders first.");return}
   let key="ek-"+r.id
   let item=UserDefaults.standard.string(forKey:key).flatMap{ek.calendarItem(withIdentifier:$0) as? EKReminder} ?? EKReminder(eventStore:ek)
   item.calendar=calendar;item.title=r.n;item.notes=r.q;item.dueDateComponents=Calendar.current.dateComponents([.year,.month,.day,.hour,.minute],from:r.d);item.isCompleted=r.done
   item.alarms=[EKAlarm(absoluteDate:r.d)]
   if r.repeatDays > 0 {item.recurrenceRules=[EKRecurrenceRule(recurrenceWith:.daily,interval:r.repeatDays,end:nil)]} else {item.recurrenceRules=nil}
   try ek.save(item,commit:true);UserDefaults.standard.set(item.calendarItemIdentifier,forKey:key)
   note=h7("Saved to Apple Reminders. Future edits there do not change this journal.")
  } catch {note=h7("Could not write to Apple Reminders. Your local care record is safe.")}
 }
 private func removeEK(_ r:H7Row) {
  guard EKEventStore.authorizationStatus(for:.reminder) == .fullAccess,let id=UserDefaults.standard.string(forKey:"ek-"+r.id),let rem=ek.calendarItem(withIdentifier:id) as? EKReminder else{return}
  try? ek.remove(rem,commit:true);UserDefaults.standard.removeObject(forKey:"ek-"+r.id)
 }
 func report() -> URL? {
  let url=FileManager.default.temporaryDirectory.appendingPathComponent("Chickgandon.csv")
  do {try H7Math.csv(z).write(to:url,atomically:true,encoding:.utf8);return url} catch {note=h7("Could not create the report.");return nil}
 }
 func sync() async {}
 func prepare988a4() throws -> Data {
  let value: [H7Row] = z
  return try JSONEncoder().encode(value)
 }
 func accept988a4(_ data:Data) throws {
  let incoming = try JSONDecoder().decode([H7Row].self, from:data)
  persist(H7Math.merged(z,incoming),schedule:false)
 }


}

