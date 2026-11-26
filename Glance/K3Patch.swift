import WidgetKit
import SwiftUI
struct K3Provider:TimelineProvider {
 func placeholder(in context:Context)->K3Entry{K3Entry(date:Date(),rows:[])}
 func getSnapshot(in context:Context,completion:@escaping(K3Entry)->Void){completion(K3Entry(date:Date(),rows:H7Math.readShared()))}
 func getTimeline(in context:Context,completion:@escaping(Timeline<K3Entry>)->Void){
  let now=Date();let rows=H7Math.readShared()
  let midnight=Calendar.current.date(byAdding:.day,value:1,to:Calendar.current.startOfDay(for:now))!
  completion(Timeline(entries:[K3Entry(date:now,rows:rows),K3Entry(date:midnight,rows:rows)],policy:.after(midnight.addingTimeInterval(300))))
 }
}
@main struct K3Patch:Widget {
 let kind="Pasture482Glance"
 var body:some WidgetConfiguration {StaticConfiguration(kind:kind,provider:K3Provider()){K3Tile(entry:$0)}.configurationDisplayName(h7("Chickgandon")).description(h7("Egg totals, feed supplies and the care your flock needs today.")).supportedFamilies([.systemSmall,.systemMedium,.systemLarge,.accessoryCircular,.accessoryRectangular,.accessoryInline])}
}
