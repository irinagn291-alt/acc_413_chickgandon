import SwiftUI
import PhotosUI
import AVFoundation

struct U5Edit:View {
 @EnvironmentObject var v:V2Nest
 @Environment(\.dismiss) private var close
 @State var r:H7Row
 @State private var photo:PhotosPickerItem?
 @State private var camera=false
 @State private var confirm=false
 @State private var working=false
 @State private var gramsText=""
 var exists:Bool {v.z.contains{$0.id == r.id}}
 var title:String {switch r.k {case "bird":return h7("Bird card");case "egg":return h7("Egg collection");case "care":return h7("Care reminder");default:return h7("Feed entry")}}
 var valid:Bool {
  if r.k == "egg" {return r.v >= 0 && r.v <= 100000 && r.v.rounded() == r.v && r.d <= Date()}
  if r.n.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty {return false}
  return r.k != "stock" || (r.v.isFinite && r.v >= 0 && r.v <= 100000)
 }
 var body:some View {
  NavigationStack{
   Form {
    if r.k == "bird" {birdFields}
    else if r.k == "egg" {
     Section(h7("Eggs collected")){DatePicker(h7("Collection date"),selection:$r.d,in:...Date(),displayedComponents:.date);TextField(h7("Egg count"),value:$r.v,format:.number.precision(.fractionLength(0))).keyboardType(.numberPad).accessibilityIdentifier("egg-count");Stepper(h7("Adjust count"),value:$r.v,in:0...100000,step:1)}
    } else if r.k == "care" {
     Section(h7("Care reminder")){TextField(h7("Task name"),text:$r.n).accessibilityIdentifier("care-name");DatePicker(h7("Due"),selection:$r.d);Picker(h7("Category"),selection:$r.b){ForEach(["Feeding","Health check","Egg collection","Other"],id:\.self){Text(h7($0)).tag($0)}};Stepper("\(h7("Repeat every (days)")): \(r.repeatDays)",value:$r.repeatDays,in:0...365);Text(h7("0 means once. The next reminder is created when you complete this one.")).font(.caption).foregroundStyle(.secondary)}
     Section {Button{Task{await v.exportEK(r)}}label:{Label(h7("Send to Apple Reminders"),systemImage:"checklist")}.disabled(!valid);Text(h7("Sending creates or updates a copy in Apple Reminders. Your local schedule also works without access.")).font(.caption).foregroundStyle(.secondary)}
    } else {
     Section(h7("Feed store")){TextField(h7("Feed name"),text:$r.n);TextField(h7("Quantity (kg)"),value:$r.v,format:.number).keyboardType(.decimalPad);DatePicker(h7("Added"),selection:$r.d,displayedComponents:.date)}
    }
    Section(h7("Notes")){TextEditor(text:$r.q).frame(minHeight:90).accessibilityLabel(h7("Notes"))}
    if exists {Section{Button(h7("Delete record"),role:.destructive){confirm=true}}}
   }.navigationTitle(title).navigationBarTitleDisplayMode(.inline)
    .toolbar{
     ToolbarItem(placement:.cancellationAction){Button(h7("Cancel")){close()}}
     ToolbarItem(placement:.confirmationAction){Button(h7("Save")){r.n=r.n.trimmingCharacters(in:.whitespacesAndNewlines);v.put(r);close()}.disabled(!valid || working).accessibilityIdentifier("save-record")}
    }
    .alert(h7("Chickgandon"),isPresented:Binding(get:{v.note != nil},set:{if !$0 {v.note=nil}})){Button(h7("OK")){v.note=nil}} message:{Text(v.note ?? "")}
    .confirmationDialog(h7("Delete this record?"),isPresented:$confirm,titleVisibility:.visible){Button(h7("Delete record"),role:.destructive){v.erase(r);close()}}
    .sheet(isPresented:$camera){U5Camera{data in if let data {r.p=data};camera=false}.ignoresSafeArea()}
    .onAppear{if r.k == "care" && r.b.isEmpty {r.b="Other"}}
    .onChange(of:photo){_,item in
     Task{working=true;defer{working=false};do{if let data=try await item?.loadTransferable(type:Data.self),let image=UIImage(data:data){r.p=U5Camera.shrink(image)}else{v.note=h7("This photo could not be opened.")}}catch{v.note=h7("This photo could not be opened.")}}
    }
  }
 }
 private var birdFields:some View {
  Group {
   Section {
    HStack {
     Spacer()
     if let p=r.p,let image=UIImage(data:p){Image(uiImage:image).resizable().scaledToFill().frame(width:145,height:145).clipShape(RoundedRectangle(cornerRadius:22))}
     else {Image(systemName:"bird.fill").font(.system(size:64)).foregroundStyle(h7Green).frame(width:145,height:145).background(h7Yellow,in:RoundedRectangle(cornerRadius:22))}
     Spacer()
    }.listRowBackground(Color.clear)
    PhotosPicker(selection:$photo,matching:.images){Label(h7("Choose bird photo"),systemImage:"photo")}
    Button{Task{guard UIImagePickerController.isSourceTypeAvailable(.camera) else{v.note=h7("A camera is not available on this device.");return};let state=AVCaptureDevice.authorizationStatus(for:.video);if state == .authorized {camera=true} else if state == .notDetermined {camera=await AVCaptureDevice.requestAccess(for:.video);if !camera {v.note=h7("Camera access is off. Choose a photo or enable the camera in device Settings.")}} else{v.note=h7("Camera access is off. Choose a photo or enable the camera in device Settings.")}}}label:{Label(h7("Take bird photo"),systemImage:"camera")}
    if r.p != nil {Button(h7("Remove photo"),role:.destructive){r.p=nil}}
   }
   Section(h7("Bird details")){TextField(h7("Name"),text:$r.n).accessibilityIdentifier("bird-name");TextField(h7("Breed"),text:$r.b).accessibilityIdentifier("bird-breed");DatePicker(h7("Hatch date"),selection:$r.d,in:...Date(),displayedComponents:.date)}
  }
 }
}
struct U5Camera:UIViewControllerRepresentable {
 var picked:(Data?)->Void
 func makeCoordinator()->C {C(picked)}
 func makeUIViewController(context:Context)->UIImagePickerController {let p=UIImagePickerController();p.sourceType = .camera;p.delegate=context.coordinator;return p}
 func updateUIViewController(_ p:UIImagePickerController,context:Context){}
 static func shrink(_ im:UIImage)->Data? {let scale=min(1,640/max(im.size.width,im.size.height));let size=CGSize(width:im.size.width*scale,height:im.size.height*scale);let format=UIGraphicsImageRendererFormat();format.scale=1;return UIGraphicsImageRenderer(size:size,format:format).image{_ in im.draw(in:CGRect(origin:.zero,size:size))}.jpegData(compressionQuality:0.78)}
 final class C:NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  var block:(Data?)->Void
  init(_ b:@escaping(Data?)->Void){block=b}
  func imagePickerControllerDidCancel(_ picker:UIImagePickerController){block(nil)}
  func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){block((info[.originalImage] as? UIImage).flatMap{U5Camera.shrink($0)})}
 }
}
