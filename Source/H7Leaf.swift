import Foundation
import SwiftUI

let h7G = "group.com.backyardcoop.app"
let h7C = "iCloud.com.backyardcoop.app"
func h7(_ s:String) -> String { NSLocalizedString(s, comment: "") }
let h7Green = Color(red:0.19,green:0.29,blue:0.19)
let h7Yellow = Color(red:0.95,green:0.81,blue:0.54)
let h7Paper = Color(red:0.98,green:0.955,blue:0.89)

struct H7Row: Codable, Identifiable, Equatable {
 var id:String = UUID().uuidString
 var k:String
 var n:String = ""
 var d:Date = Date()
 var v:Double = 0
 var b:String = ""
 var q:String = ""
 var p:Data? = nil
 var done:Bool = false
 var repeatDays:Int = 0
 var u:Date = Date()
 var gone:Bool = false
}
struct H7Box:Codable {
 var rows:[H7Row] = []
 var version:Int = 1
}
enum H7Math {
 static func active(_ x:[H7Row],_ k:String) -> [H7Row] { x.filter { !$0.gone && $0.k == k } }
 static func day(_ d:Date) -> Date { Calendar.current.startOfDay(for:d) }
 static func week(_ x:[H7Row], _ now:Date = Date()) -> [(Date,Int)] {
  let end=day(now)
  return (-6...0).map { off in
   let d=Calendar.current.date(byAdding:.day,value:off,to:end)!
   return (d, active(x,"egg").filter { Calendar.current.isDate($0.d,inSameDayAs:d) }.reduce(0){$0+Int($1.v)})
  }
 }
 static func due(_ x:[H7Row], _ now:Date = Date()) -> [H7Row] {
  let end=Calendar.current.date(byAdding:.day,value:1,to:day(now))!
  return active(x,"care").filter { !$0.done && $0.d < end }.sorted { $0.d < $1.d }
 }
 static func ration(_ count:Int,_ grams:Double,_ days:Int) -> Double { Double(max(0,count))*max(0,grams)*Double(max(0,days))/1000 }
 static func merged(_ a:[H7Row],_ b:[H7Row]) -> [H7Row] {
  var bag=Dictionary(a.map{($0.id,$0)},uniquingKeysWith: { $0.u >= $1.u ? $0 : $1 })
  for r in b { if bag[r.id] == nil || bag[r.id]!.u < r.u { bag[r.id]=r } }
  return bag.values.sorted { $0.id < $1.id }
 }
 static func csv(_ x:[H7Row]) -> String {
  func esc(_ s:String)->String { let z=(s.first.map{ "=+-@\t\r".contains($0) } ?? false) ? "'"+s : s; return "\""+z.replacingOccurrences(of:"\"",with:"\"\"")+"\"" }
  let f=ISO8601DateFormatter()
  return "\u{FEFF}type,name,date,value,breed_or_category,notes,completed\r\n"+x.filter{ !$0.gone }.sorted{$0.d < $1.d}.map { r in
   [r.k,r.n,f.string(from:r.d),String(r.v),r.b,r.q,r.done ? "yes":"no"].map(esc).joined(separator:",")
  }.joined(separator:"\r\n")
 }
 static func readShared()->[H7Row] {
  guard let base=FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:h7G),let d=try? Data(contentsOf:base.appendingPathComponent("yard.json")),let box=try? JSONDecoder().decode(H7Box.self,from:d) else { return [] }
  return box.rows
 }
}
struct H7Bars:View {
 var r:[H7Row]; var now:Date = Date()
 var body:some View {
  let days=H7Math.week(r,now); let m=max(1,days.map{$0.1}.max() ?? 1)
  HStack(alignment:.bottom,spacing:8) {
   ForEach(days,id:\.0) { d,n in
    VStack(spacing:5) {
     Text("\(n)").font(.caption2.monospacedDigit()).foregroundStyle(.secondary)
     RoundedRectangle(cornerRadius:5).fill(n == 0 ? h7Green.opacity(0.12):h7Green).frame(height:max(3,CGFloat(n)/CGFloat(m)*58))
     Text(d,format:.dateTime.weekday(.narrow)).font(.caption2)
    }.frame(maxWidth:.infinity)
   }
  }.frame(height:100).accessibilityElement(children:.ignore)
   .accessibilityLabel(h7("Weekly eggs")+": "+days.map{String($0.1)}.joined(separator:", "))
 }
}
struct H7Article:Decodable,Identifiable { var id:String; var icon:String; var title:String; var body:String; var source:String }
func h7Articles()->[H7Article] {
 guard let url=Bundle.main.url(forResource:"FieldNotes",withExtension:"json"),let data=try? Data(contentsOf:url) else {return []}
 return (try? JSONDecoder().decode([H7Article].self,from:data)) ?? []
}

import WidgetKit
struct K3Entry:TimelineEntry {var date:Date;var rows:[H7Row]}
struct K3Tile:View {
 @Environment(\.widgetFamily) private var systemFamily
 var entry:K3Entry
 var sampleFamily:WidgetFamily? = nil
 private var family:WidgetFamily {sampleFamily ?? systemFamily}
 var due:[H7Row]{H7Math.due(entry.rows,entry.date)}
 var planned:[H7Row]{H7Math.active(entry.rows,"care").filter{!$0.done}.sorted{$0.d < $1.d}}
 var body:some View {
  Group {
   switch family {
   case .accessoryInline:Text("\(h7("Care due")): \(due.count)")
   case .accessoryCircular:VStack{Image(systemName:"calendar");Text("\(due.count)").bold()}.accessibilityLabel(h7("Care due")+": \(due.count)")
   case .accessoryRectangular:VStack(alignment:.leading){Label(h7("Care today"),systemImage:"bird");Text("\(due.count) "+h7("reminders")).bold()}
   case .systemMedium:HStack(spacing:20){VStack(alignment:.leading,spacing:8){Label(h7("Care today"),systemImage:"sun.max").font(.headline);Text("\(due.count)").font(.largeTitle.bold());Text(due.first?.n ?? h7("No care due")).font(.caption).lineLimit(2)}.frame(maxWidth:.infinity,alignment:.leading);H7Bars(r:entry.rows,now:entry.date).frame(maxWidth:.infinity)}
   case .systemLarge:VStack(alignment:.leading,spacing:14){Label(h7("Chickgandon"),systemImage:"bird.fill").font(.headline).foregroundStyle(h7Green);HStack{metric("Birds","\(H7Math.active(entry.rows,"bird").count)");Spacer();metric("Feed store",String(format:"%.1f kg",H7Math.active(entry.rows,"stock").reduce(0){$0+$1.v}));Spacer();metric("Care due","\(due.count)")};H7Bars(r:entry.rows,now:entry.date);Divider();Text(h7("Care calendar")).font(.subheadline.bold());if planned.isEmpty{Text(h7("No care due")).font(.caption)}else{ForEach(planned.prefix(3)){r in HStack{Image(systemName:"circle");Text(r.n).lineLimit(1);Spacer();Text(r.d,format:.dateTime.day().month())}.font(.caption)}};Spacer(minLength:0)}
   default:VStack(alignment:.leading,spacing:4){Text(h7("Weekly eggs")).font(.caption.bold());Text("\(H7Math.week(entry.rows,entry.date).reduce(0){$0+$1.1})").font(.system(size:32,weight:.bold,design:.rounded)).foregroundStyle(h7Green);H7Bars(r:entry.rows,now:entry.date).scaleEffect(y:0.75,anchor:.bottom).frame(height:65)}
   }
  }.containerBackground(for:.widget){h7Paper}
   .widgetURL(URL(string:family == .systemSmall ? "coop482://journal":"coop482://care"))
 }
 func metric(_ key:String,_ value:String)->some View {VStack(alignment:.leading){Text(value).font(.title2.bold());Text(h7(key)).font(.caption2).foregroundStyle(.secondary)}}
}
