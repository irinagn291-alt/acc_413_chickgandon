import SwiftUI

@main struct B8Yard:App {
 @StateObject private var v=V2Nest()
 @Environment(\.scenePhase) private var phase
 var body:some Scene {
  WindowGroup {
   Group {
#if targetEnvironment(simulator)
    if let index = StoreCaptureRoute.index { StoreCaptureScene(index: index) }
    else { B8Tabs() }
#else
    B8Tabs()
#endif
}.environmentObject(v).tint(h7Green).preferredColorScheme(.light)
    .onChange(of:phase){_,p in if p == .active {Task{await v.refreshNotices();await v.reschedule();if v.syncOn {await v.sync()}}}}
  }
 }
}
struct B8Tabs:View {
 @EnvironmentObject var v:V2Nest
 @Environment(\.horizontalSizeClass) private var widthClass
 @Environment(\.dynamicTypeSize) private var typeSize
 @State private var page=0
 @State private var sheet:H7Row?
 @State private var settings=false
 var body:some View {
  TabView(selection:$page) {
   NavigationStack { flock }.tabItem{Label(h7("Flock"),systemImage:"bird")}.tag(0)
   NavigationStack { journal }.tabItem{Label(h7("Journal"),systemImage:"chart.bar.xaxis")}.tag(1)
   NavigationStack { B8Feed() }.tabItem{Label(h7("Feed"),systemImage:"leaf")}.tag(2)
   NavigationStack { B8Care() }.tabItem{Label(h7("Care"),systemImage:"calendar")}.tag(3)
   NavigationStack { B8Guide() }.tabItem{Label(h7("Guide"),systemImage:"book.closed")}.tag(4)
  }.sheet(item:$sheet){U5Edit(r:$0).environmentObject(v)}
   .sheet(isPresented:$settings){B8Settings().environmentObject(v)}
   .alert(h7("Chickgandon"),isPresented:Binding(get:{v.note != nil && sheet == nil && !settings},set:{if !$0 {v.note=nil}})){Button(h7("OK")){v.note=nil}} message:{Text(v.note ?? "")}
   .onOpenURL{u in if u.host == "care" {page=3} else if u.host == "journal" {page=1} else {page=0}}
 }
 private var flock:some View {
  ScrollView {
   VStack(alignment:.leading,spacing:22) {
    if widthClass == .regular && !typeSize.isAccessibilitySize {
     HStack(alignment: .center, spacing: 26) {
      flockCover.frame(maxWidth: .infinity)
      summary.frame(width: 268)
     }
    } else {
     flockCover
     summary
    }
    HStack {Text(h7("Your birds")).font(.system(.title, design: .serif, weight: .bold));Spacer();Button{sheet=H7Row(k:"bird",d:Calendar.current.date(byAdding:.month,value:-6,to:Date())!)}label:{Label(h7("Add bird"),systemImage:"plus.circle.fill").font(.subheadline.bold())}.accessibilityIdentifier("add-bird")}
    let birds=H7Math.active(v.z,"bird").sorted{$0.n.localizedStandardCompare($1.n) == .orderedAscending}
    if birds.isEmpty {B8Empty(icon:"bird",title:"Make room for your flock",body:"Add your first bird with a name, breed and hatch date. Your records stay on this device.")}
    LazyVGrid(columns:[GridItem(.adaptive(minimum:270),spacing:14)],spacing:14) {
     ForEach(birds){b in
      Button{sheet=b} label:{HStack(spacing:14){
       if let p=b.p,let image=UIImage(data:p){Image(uiImage:image).resizable().scaledToFill().frame(width:72,height:82).clipShape(RoundedRectangle(cornerRadius:14))}
       else {Text(String(b.n.prefix(1))).font(.system(.largeTitle, design:.serif, weight:.bold)).foregroundStyle(h7Green).frame(width:62,height:72).background(h7Yellow.opacity(0.56),in:RoundedRectangle(cornerRadius:8))}
       VStack(alignment:.leading,spacing:5){Text(b.n).font(.headline);Text(b.b.isEmpty ? h7("Breed not recorded"):b.b).font(.subheadline).foregroundStyle(.secondary);Text(b.d,style:.relative).font(.caption).foregroundStyle(h7Green)}
       Spacer();Image(systemName:"chevron.right").font(.caption)
      }.padding(13).background(.white,in:RoundedRectangle(cornerRadius:20))}.buttonStyle(.plain)
     }
    }
   }.padding(20).frame(maxWidth:1050).frame(maxWidth:.infinity)
  }.background(h7Paper).navigationTitle(h7("Chickgandon")).navigationBarTitleDisplayMode(.inline)
   .toolbar{ToolbarItem(placement:.topBarTrailing){Button{settings=true}label:{Image(systemName:"gearshape")}.accessibilityLabel(h7("Settings"))}}
 }
 private var flockCover: some View {
  VStack(alignment: .leading, spacing: 0) {
   Image("CoopPress").resizable().aspectRatio(1.5, contentMode: .fit).accessibilityHidden(true)
   VStack(alignment: .leading, spacing: 4) {
    Text(Date(), format: .dateTime.weekday(.wide).month(.wide).day())
     .font(.system(.caption, design: .monospaced, weight: .semibold)).textCase(.uppercase).tracking(1.3)
    Text(h7("Flock")).font(.system(.largeTitle, design: .serif, weight: .heavy))
   }.padding(.horizontal, 18).padding(.vertical, 12).frame(maxWidth: .infinity, alignment: .leading)
    .foregroundStyle(h7Paper).background(h7Green)
  }.clipShape(RoundedRectangle(cornerRadius: 7))
 }
 private var summary: some View {
  VStack(spacing: 12) {
   HStack(spacing: 0) {
    B8Stat(value:"\(H7Math.active(v.z,"bird").count)",key:"Birds",icon:"bird.fill",yellow:true)
    Rectangle().fill(h7Green.opacity(0.3)).frame(width:1)
    B8Stat(value:"\(H7Math.week(v.z).reduce(0){$0+$1.1})",key:"Weekly eggs",icon:"oval.portrait.fill",yellow:false)
   }.fixedSize(horizontal:false, vertical:true)
   Divider().overlay(h7Green.opacity(0.5))
   Button { page = 3 } label: {
    HStack {
     Image(systemName:"sun.horizon.fill").foregroundStyle(coopRust)
     Text(h7("Care due")).font(.headline)
     Spacer()
     Text("\(H7Math.due(v.z).count)").font(.headline.monospacedDigit())
     Image(systemName:"chevron.right").font(.footnote)
    }.padding(.horizontal,10).frame(minHeight:44)
   }.buttonStyle(.plain)
   Divider().overlay(h7Green.opacity(0.5))
  }
 }
 private var journal:some View {
  ScrollView {
   VStack(alignment:.leading,spacing:20) {
    Text(Date(),format:.dateTime.month(.wide).year()).font(.system(.title,design:.serif,weight:.bold)).foregroundStyle(h7Green)
    Button{sheet=H7Row(k:"egg")}label:{Label(h7("Log eggs"),systemImage:"plus").frame(maxWidth:.infinity).padding(8)}.buttonStyle(.borderedProminent).accessibilityIdentifier("log-eggs")
    CoopWeekLedger(days:H7Math.week(v.z))
    let rows=H7Math.active(v.z,"egg").sorted{$0.d > $1.d}
    if rows.isEmpty {B8Empty(icon:"oval.portrait",title:"Your egg diary starts here",body:"Record each collection. The chart totals all collections for each day.")}
    else {
     HStack{Text(h7("Collection date"));Spacer();Text(h7("Eggs"))}.font(.caption.bold()).foregroundStyle(.secondary)
     ForEach(rows){r in Button{sheet=r}label:{HStack{VStack(alignment:.leading,spacing:5){Text(r.d,format:.dateTime.day().month().year()).font(.headline);if !r.q.isEmpty {Text(r.q).font(.caption).foregroundStyle(.secondary).lineLimit(2)}};Spacer();Text("\(Int(r.v))").font(.title2.bold().monospacedDigit()).foregroundStyle(h7Green);Image(systemName:"pencil").font(.caption)}.padding(16).background(.white,in:RoundedRectangle(cornerRadius:16))}.buttonStyle(.plain)}
    }
   }.padding(20).frame(maxWidth:1050).frame(maxWidth:.infinity)
  }.background(h7Paper).navigationTitle(h7("Egg journal"))
   .toolbar{if let url=v.report(){ShareLink(item:url){Label(h7("Export report"),systemImage:"square.and.arrow.up")}}}
 }
}
private struct CoopWeekLedger: View {
 let days: [(Date, Int)]
 @Environment(\.dynamicTypeSize) private var typeSize
 private var peak: Int { max(1, days.map { $0.1 }.max() ?? 1) }

 var body: some View {
  VStack(alignment: .leading, spacing: 0) {
   HStack(alignment: .firstTextBaseline) {
    Text(h7("Last 7 days")).font(.system(.title3, design:.serif, weight:.bold))
    Spacer()
    Text("\(days.reduce(0) { $0 + $1.1 })").font(.system(.title2, design:.serif, weight:.bold)).monospacedDigit()
   }.padding(.bottom,10)
   ForEach(days, id: \.0) { date, count in
    Divider().overlay(h7Green.opacity(0.24))
    HStack(spacing: 10) {
     Text(date,format:.dateTime.weekday(.abbreviated).day()).font(.caption.weight(.semibold))
      .frame(minWidth:55,alignment:.leading).layoutPriority(1)
     if !typeSize.isAccessibilitySize {
      Canvas { context, size in
        let y = size.height/2
        if peak <= 12 {
         let gap = min(16, size.width / 12)
         for i in 0..<max(0, count) {
          let rect = CGRect(x:CGFloat(i)*gap, y:y-5, width:min(8,gap*0.75), height:11)
          var egg=Path()
          egg.move(to:CGPoint(x:rect.midX,y:rect.minY))
          egg.addQuadCurve(to:CGPoint(x:rect.maxX,y:rect.midY+1),control:CGPoint(x:rect.maxX-1,y:rect.minY+1))
          egg.addQuadCurve(to:CGPoint(x:rect.midX,y:rect.maxY),control:CGPoint(x:rect.maxX+1,y:rect.maxY))
          egg.addQuadCurve(to:CGPoint(x:rect.minX,y:rect.midY+1),control:CGPoint(x:rect.minX-1,y:rect.maxY))
          egg.addQuadCurve(to:CGPoint(x:rect.midX,y:rect.minY),control:CGPoint(x:rect.minX+1,y:rect.minY+1))
          context.fill(egg,with:.color(coopRust))
         }
        } else if count > 0 {
         let rect = CGRect(x:0,y:y-3,width:size.width * CGFloat(count) / CGFloat(peak),height:6)
         context.fill(Path(roundedRect:rect,cornerRadius:3),with:.color(coopRust))
        }
      }.frame(height:18).accessibilityHidden(true)
     } else { Spacer(minLength:0) }
     Text("\(count)").font(.body.monospacedDigit()).foregroundStyle(count == 0 ? h7Green.opacity(0.7) : h7Green)
    }.padding(.vertical,5).accessibilityElement(children:.ignore)
     .accessibilityLabel(date.formatted(date:.complete,time:.omitted)+", "+String(count)+" "+h7("Eggs"))
   }
  }.padding(16).foregroundStyle(h7Green).background(h7Yellow.opacity(0.22))
   .overlay(alignment:.top){Rectangle().fill(coopRust).frame(height:2)}
 }
}

struct B8Stat:View {
 var value:String;var key:String;var icon:String;var yellow:Bool
 var body:some View {
  VStack(alignment:.leading,spacing:2) {
   HStack(alignment:.center,spacing:8) {
    Text(value).font(.system(.largeTitle,design:.serif,weight:.bold)).monospacedDigit()
    Image(systemName:icon).font(.subheadline).foregroundStyle(yellow ? coopRust : h7Green)
   }
   Text(h7(key)).font(.subheadline)
  }.frame(maxWidth:.infinity,alignment:.leading).padding(.horizontal,12).foregroundStyle(h7Green)
 }
}
private let coopRust = Color(red:0.52, green:0.20, blue:0.105)

struct B8Empty:View {
 var icon:String;var title:String;var copy:String
 init(icon:String,title:String,body:String){self.icon=icon;self.title=title;self.copy=body}
 var bodyView: some View {
  HStack(alignment:.top,spacing:15) {
   Image(systemName:icon).font(.title2).foregroundStyle(coopRust)
   VStack(alignment:.leading,spacing:6) {
    Text(h7(title)).font(.system(.headline,design:.serif,weight:.bold))
    Text(h7(copy)).font(.subheadline).foregroundStyle(h7Green).fixedSize(horizontal:false,vertical:true)
   }
  }.padding(16).frame(maxWidth:.infinity,alignment:.leading)
   .background(h7Yellow.opacity(0.26)).overlay(alignment:.leading){Rectangle().fill(coopRust).frame(width:3)}
 }
 var body:some View {bodyView}
}
struct B8Feed:View {
 @EnvironmentObject var v:V2Nest
 @State private var count=1
 @State private var grams=115.0
 @State private var days=7
 @State private var sheet:H7Row?
 @State private var use=false
 @State private var kg=0.0
 var total:Double {H7Math.active(v.z,"stock").reduce(0){$0+$1.v}}
 var body:some View {
  ScrollView {VStack(alignment:.leading,spacing:20){
   Text(h7("Good feed. Healthy hens.")).font(.system(.largeTitle,design:.serif,weight:.semibold))
   VStack(alignment:.leading,spacing:16){
    Label(h7("Ration planner"),systemImage:"leaf.fill").font(.headline).foregroundStyle(h7Green)
    Text(h7("For adult laying hens on complete layer feed. Adjust to the feed label, bird condition and local advice.")).font(.footnote).foregroundStyle(.secondary)
    Stepper("\(h7("Birds")): \(count)",value:$count,in:1...10000)
    HStack{Text(h7("Grams per bird / day"));Spacer();TextField("115",value:$grams,format:.number).keyboardType(.decimalPad).multilineTextAlignment(.trailing).frame(width:85).accessibilityIdentifier("ration-grams")}
    Stepper("\(h7("Days")): \(days)",value:$days,in:1...365)
    Divider();HStack{Text(h7("Feed needed"));Spacer();if grams.isFinite && grams > 0 && grams <= 500 {Text(H7Math.ration(count,grams,days),format:.number.precision(.fractionLength(2))).font(.title.bold());Text("kg")} else {Text(h7("Enter 1–500 grams")).foregroundStyle(.orange)}}.foregroundStyle(h7Green)
    Text(h7("Baseline: 115 g per hen daily. This is a planning estimate, not a feed formulation.")).font(.caption).foregroundStyle(.secondary)
   }.padding(20).background(.white,in:RoundedRectangle(cornerRadius:22))
   HStack{Text(h7("Feed store")).font(.title2.bold());Spacer();Button{sheet=H7Row(k:"stock")}label:{Label(h7("Add feed"),systemImage:"plus.circle.fill")}}
   HStack{Text(total,format:.number.precision(.fractionLength(2))).font(.system(size:38,weight:.bold,design:.rounded));Text(h7("kg in store"));Spacer();Image(systemName:"shippingbox.fill").font(.largeTitle).foregroundStyle(h7Green)}.padding(20).background(h7Yellow,in:RoundedRectangle(cornerRadius:20))
   if total > 0 {Button{kg=min(0.5,total);use=true}label:{Label(h7("Record feed used"),systemImage:"minus.circle")}.buttonStyle(.bordered)}
   ForEach(H7Math.active(v.z,"stock")){r in Button{sheet=r}label:{HStack{Text(r.n).font(.headline);Spacer();Text(r.v,format:.number.precision(.fractionLength(2)));Text("kg");Image(systemName:"pencil")}.padding(17).background(.white,in:RoundedRectangle(cornerRadius:16))}.buttonStyle(.plain)}
   if H7Math.active(v.z,"stock").isEmpty {B8Empty(icon:"shippingbox",title:"Keep an eye on supplies",body:"Add the feed you have in storage, then record what you use.")}
  }.padding(20).frame(maxWidth:900).frame(maxWidth:.infinity)}
  .background(h7Paper).navigationTitle(h7("Feed & supplies"))
  .onAppear{count=max(1,H7Math.active(v.z,"bird").count)}
  .sheet(item:$sheet){U5Edit(r:$0).environmentObject(v)}
  .sheet(isPresented:$use){NavigationStack{Form{Section(h7("Feed used (kg)")){TextField("kg",value:$kg,format:.number).keyboardType(.decimalPad);Text(h7("The amount is deducted from your oldest feed entries first.")).font(.caption)}}.navigationTitle(h7("Record feed used")).toolbar{ToolbarItem(placement:.cancellationAction){Button(h7("Cancel")){use=false}};ToolbarItem(placement:.confirmationAction){Button(h7("Save")){var remaining=kg;for var r in H7Math.active(v.z,"stock").sorted(by:{$0.d < $1.d}) where remaining > 0 {let used=min(r.v,remaining);r.v-=used;remaining-=used;v.put(r)};use=false}.disabled(!kg.isFinite || kg <= 0 || kg > total)}}}.presentationDetents([.medium,.large])}
 }
}
struct B8Care:View {
 @EnvironmentObject var v:V2Nest
 @State private var sheet:H7Row?
 @State private var selected=Date()
 @State private var all=true
 @State private var showDone=false
 var body:some View {
  ScrollView{VStack(alignment:.leading,spacing:18){
   Text(h7("Little routines,\nlasting wellbeing.")).font(.system(.largeTitle,design:.serif,weight:.semibold))
   Button{sheet=H7Row(k:"care",n:h7("Collect eggs"),d:Date().addingTimeInterval(3600))}label:{Label(h7("Add care reminder"),systemImage:"plus").frame(maxWidth:.infinity).padding(7)}.buttonStyle(.borderedProminent).accessibilityIdentifier("add-care")
   DatePicker(h7("Care calendar"),selection:$selected,displayedComponents:.date).datePickerStyle(.graphical).padding(10).background(.white,in:RoundedRectangle(cornerRadius:20))
   Toggle(h7("Show all dates"),isOn:$all);Toggle(h7("Include completed"),isOn:$showDone)
   let rows=H7Math.active(v.z,"care").filter{(showDone || !$0.done) && (all || Calendar.current.isDate($0.d,inSameDayAs:selected))}.sorted{$0.d < $1.d}
   if rows.isEmpty {B8Empty(icon:"calendar.badge.checkmark",title:"A little care goes a long way",body:"Plan feeding, egg collection or a health check. Alerts are optional; the calendar always works offline.")}
   ForEach(rows){r in HStack(alignment:.top,spacing:12){
    Button{if !r.done {v.finish(r)}}label:{Image(systemName:r.done ? "checkmark.circle.fill":"circle").font(.title2).foregroundStyle(h7Green)}.disabled(r.done).accessibilityLabel(h7("Complete care")+": "+r.n)
    Button{sheet=r}label:{VStack(alignment:.leading,spacing:7){Text(r.n).font(.headline).strikethrough(r.done);Text(r.d,format:.dateTime.day().month().hour().minute()).font(.caption).foregroundStyle(r.d < Date() && !r.done ? .orange:.secondary);if r.repeatDays > 0 {Text("\(h7("Repeat every (days)")): \(r.repeatDays)").font(.caption)};if !r.q.isEmpty {Text(r.q).font(.caption).foregroundStyle(.secondary)}}.frame(maxWidth:.infinity,alignment:.leading)}.buttonStyle(.plain)
    Button{Task{await v.exportEK(r)}}label:{Image(systemName:"square.and.arrow.up")}.accessibilityLabel(h7("Send to Apple Reminders"))
   }.padding(16).background(.white,in:RoundedRectangle(cornerRadius:18))}
   Text(h7("Repeating care creates the next due date when completed. Up to 60 upcoming alerts are scheduled; opening the app refreshes them.")).font(.caption).foregroundStyle(.secondary)
  }.padding(20).frame(maxWidth:900).frame(maxWidth:.infinity)}.background(h7Paper).navigationTitle(h7("Care calendar")).sheet(item:$sheet){U5Edit(r:$0).environmentObject(v)}
 }
}
struct B8Guide:View {
 @EnvironmentObject var v:V2Nest
 @State private var season="Spring"
 @State private var search=""
 let seasons=["Spring","Summer","Autumn","Winter"]
 var tasks:[String] {switch season{case "Summer":return ["Check shade and water","Inspect for mites","Keep feed cool and dry"];case "Autumn":return ["Check shelter for drafts","Inspect roof and fencing","Review feed supplies"];case "Winter":return ["Keep drinking water unfrozen","Keep bedding dry","Check ventilation daily"];default:return ["Deep clean the coop","Inspect birds and bedding","Check predator barriers"]}}
 var body:some View {
  ScrollView{VStack(alignment:.leading,spacing:18){
   Text(h7("A field guide\nfor everyday care.")).font(.system(.largeTitle,design:.serif,weight:.semibold))
   Text(h7("Seasonal checklist")).font(.title2.bold())
   Picker(h7("Season"),selection:$season){ForEach(seasons,id:\.self){Text(h7($0)).tag($0)}}.pickerStyle(.segmented)
   Text(h7("Choose the season where you live. Checks are kept for the current year.")).font(.caption).foregroundStyle(.secondary)
   ForEach(tasks,id:\.self){s in
    let id="check-\(Calendar.current.component(.year,from:Date()))-\(season)-\(s)"
    let old=v.z.first{$0.id == id};let checked=old?.done ?? false
    Button{var r=old ?? H7Row(id:id,k:"check",n:s);r.done.toggle();v.put(r)}label:{HStack{Image(systemName:checked ? "checkmark.square.fill":"square");Text(h7(s)).frame(maxWidth:.infinity,alignment:.leading)}}.buttonStyle(.plain).foregroundStyle(h7Green).padding(15).background(.white,in:RoundedRectangle(cornerRadius:14))
   }
   Text(h7("Feed & health library")).font(.title2.bold()).padding(.top,10)
   ForEach(h7Articles().filter{search.isEmpty || h7($0.title).localizedCaseInsensitiveContains(search) || h7($0.body).localizedCaseInsensitiveContains(search)}){a in
    NavigationLink{ScrollView{VStack(alignment:.leading,spacing:22){Image(systemName:a.icon).font(.largeTitle).foregroundStyle(h7Green);Text(h7(a.title)).font(.system(.largeTitle,design:.serif,weight:.semibold));Text(h7(a.body)).font(.body).lineSpacing(6);Divider();Text(h7("Reference")).font(.caption.bold());Link(h7("Read the source"),destination:URL(string:a.source)!)}.padding(24).frame(maxWidth:850).frame(maxWidth:.infinity)}.background(h7Paper).navigationTitle(h7("Field guide")).navigationBarTitleDisplayMode(.inline)}label:{HStack{Image(systemName:a.icon).frame(width:28).foregroundStyle(h7Green);Text(h7(a.title)).font(.headline);Spacer();Image(systemName:"chevron.right").font(.caption)}.padding(17).background(.white,in:RoundedRectangle(cornerRadius:16))}.buttonStyle(.plain)
   }
  }.padding(20).frame(maxWidth:1000).frame(maxWidth:.infinity)}.background(h7Paper).navigationTitle(h7("Field guide")).searchable(text:$search,prompt:h7("Search the guide"))
 }
}
struct B8Settings:View {
 @EnvironmentObject var v:V2Nest
 @Environment(\.dismiss) var dismiss
 var body:some View {
  NavigationStack{Form{
   Section(h7("Care notifications")){Text(h7("Get a local alert at each care time. Permission is optional and can be changed in device Settings.")).font(.subheadline);Button(h7("Enable care alerts")){Task{await v.enableNotices()}};Text(v.notices ? h7("Alerts enabled"):h7("Alerts are off")).foregroundStyle(.secondary);Button(h7("Open device Settings")){if let u=URL(string:UIApplication.openSettingsURLString){UIApplication.shared.open(u)}}}
   F988a4(encode: v.prepare988a4, apply: v.accept988a4)
   Section(h7("Your data")){if let url=v.report(){ShareLink(item:url){Label(h7("Export report"),systemImage:"square.and.arrow.up")}};NavigationLink(h7("Privacy & app information")){ScrollView{Text(h7("No ads, purchases, analytics or tracking. Flock photos, notes and care records stay on your device. If enabled, iCloud stores them in your private Apple account. Apple Reminders receives only care items you choose to send. Shared reports are controlled by you. Delete any record from its edit screen. No account is required. The field guide is educational and does not diagnose illness; contact a poultry veterinarian for sick birds.")).padding(24)}.navigationTitle(h7("Privacy"))}}
   Section {Text(h7("Chickgandon")).bold();Text("1.4.2 · 482").font(.caption)}
  }.navigationTitle(h7("Settings")).alert(h7("Chickgandon"),isPresented:Binding(get:{v.note != nil},set:{if !$0 {v.note=nil}})){Button(h7("OK")){v.note=nil}} message:{Text(v.note ?? "")}.toolbar{ToolbarItem(placement:.confirmationAction){Button(h7("Done")){dismiss()}}}}
 }
}

import UniformTypeIdentifiers

private struct F988a4:View {
 let encode:() throws -> Data
 let apply:(Data) throws -> Void
 @Environment(\.locale) private var language
 @State private var exporting=false
 @State private var importing=false
 @State private var document:Envelope?
 @State private var status=""
 private var labels:[String] {
  let words:[String:[String]]=["en":["Export file","Import file","File imported"],"de":["Datei exportieren","Datei importieren","Datei importiert"],"fr":["Exporter un fichier","Importer un fichier","Fichier importé"],"pt":["Exportar arquivo","Importar arquivo","Arquivo importado"]]
  return words[language.language.languageCode?.identifier ?? "en"] ?? words["en"]!
 }
 private struct Envelope:FileDocument {
  static var readableContentTypes:[UTType]{[.json]}
  let contents:Data
  init(contents:Data){self.contents=contents}
  init(configuration:ReadConfiguration)throws{guard let data=configuration.file.regularFileContents else{throw CocoaError(.fileReadCorruptFile)};contents=data}
  func fileWrapper(configuration:WriteConfiguration)throws->FileWrapper{FileWrapper(regularFileWithContents:contents)}
 }
 var body:some View {
  VStack(alignment:.leading,spacing:12){
   Button {do {let payload=try encode();let obj=try JSONSerialization.jsonObject(with:payload,options:[.fragmentsAllowed])
    document=Envelope(contents:try JSONSerialization.data(withJSONObject:["format":"com.backyardcoop.app/1","payload":obj]));status="";exporting=true
   }catch{status=error.localizedDescription}} label:{Label(labels[0],systemImage:"square.and.arrow.up")}.buttonStyle(.borderless)
   Button {importing=true} label:{Label(labels[1],systemImage:"square.and.arrow.down")}.buttonStyle(.borderless)
   if !status.isEmpty{Text(status).font(.footnote).foregroundStyle(.secondary)}
  }.fileExporter(isPresented:$exporting,document:document,contentType:.json,defaultFilename:"Chickgandon - Coop journal"){
   if case .failure(let error)=$0{status=error.localizedDescription}
  }.fileImporter(isPresented:$importing,allowedContentTypes:[.json]){
   do {let url=try $0.get();let scoped=url.startAccessingSecurityScopedResource();defer{if scoped{url.stopAccessingSecurityScopedResource()}}
    guard let size=try url.resourceValues(forKeys:[.fileSizeKey]).fileSize,size>0,size<100_000_000 else{throw CocoaError(.fileReadTooLarge)}
    let raw=try JSONSerialization.jsonObject(with:Data(contentsOf:url))
    guard let envelope=raw as? [String:Any],envelope["format"] as? String=="com.backyardcoop.app/1",let payload=envelope["payload"] else{throw CocoaError(.fileReadCorruptFile)}
    try apply(JSONSerialization.data(withJSONObject:payload,options:[.fragmentsAllowed]));status=labels[2]
   }catch{status=error.localizedDescription}
  }
 }
}

#if targetEnvironment(simulator)
private enum StoreCaptureRoute {
    static var index: Int? {
        let process = ProcessInfo.processInfo
        let args = process.arguments
        if let at = args.firstIndex(of:"-ReviewScreen"), args.indices.contains(at+1) {
            return ["flock-almanac", "egg-journal", "ration-planner", "care-calendar", "seasonal-guide", "bird-card"].firstIndex(of:args[at+1])
        }
        guard args.contains("-AppStoreScreenshots") || process.environment["APPSTORE_SCREENSHOTS"] == "1" else { return nil }
        if let at = args.firstIndex(of: "-AppStoreScreenshotScreen"), args.indices.contains(at+1) { return Int(args[at+1]) }
        return Int(process.environment["APPSTORE_SCREENSHOT_SCREEN"] ?? "0")
    }
}

@MainActor private struct StoreCaptureScene: View {
    let index: Int
    @StateObject private var model: V2Nest
    init(index: Int) {
        self.index = index
        let m = V2Nest()
        let now = Date()
        func days(_ n: Int) -> Date { Calendar.current.date(byAdding: .day, value: n, to: now)! }
        let birds = [("Hazel", "Buff Orpington"), ("Juniper", "Plymouth Rock"), ("Mabel", "Sussex"), ("Pearl", "Leghorn"), ("Olive", "Australorp")]
        m.z = birds.enumerated().map { i, b in H7Row(k:"bird", n:b.0, d:days(-240-i*20), b:b.1, q:"First to the feeder each morning.") }
        for (i, n) in [4,3,5,2,4,3,5].enumerated() {
            m.z.append(H7Row(k:"egg", n:"Morning collection", d:days(-i), v:Double(n)))
        }
        m.z.append(H7Row(k:"stock", n:"Layer pellets", v:18.5))
        m.z.append(H7Row(k:"stock", n:"Oyster shell", v:3.25))
        for (i, n) in ["Refresh waterers", "Turn the bedding", "Inspect the fencing"].enumerated() {
            m.z.append(H7Row(k:"care", n:n, d:days(i), repeatDays:i == 0 ? 1 : 7))
        }
        _model = StateObject(wrappedValue:m)
    }
    var body: some View {
        Group {
            if index == 5 { U5Edit(r:model.z[0]) }
            else { B8Tabs(storePage:index) }
        }.environmentObject(model)
    }
}
private extension B8Tabs {
    init(storePage: Int) { _page = State(initialValue:storePage) }
}

#endif
