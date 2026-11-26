import XCTest
#if COOP_UI
final class N6Wings:XCTestCase {
 @MainActor func testFarmJourney() throws {
  let a=XCUIApplication();a.launchEnvironment["COOP_QA"]="1";a.launchArguments=["-AppleLanguages","(en)","-AppleLocale","en_US"];a.launch()
  func shot(_ name:String){let p=XCTAttachment(screenshot:a.screenshot());p.name=name;p.lifetime = .keepAlways;add(p)}
  func tapTab(_ label:String){let b=a.tabBars.buttons[label];if b.exists{b.tap()}else{a.buttons[label].firstMatch.tap()}}
  XCTAssertTrue(a.buttons["add-bird"].waitForExistence(timeout:20));shot("01-fresh-flock")
  a.buttons["add-bird"].tap();let name=a.textFields["bird-name"];XCTAssertTrue(name.waitForExistence(timeout:5));name.tap();name.typeText("Hazel")
  let breed=a.textFields["bird-breed"];breed.tap();breed.typeText("Orpington");a.buttons["save-record"].tap();XCTAssertTrue(a.staticTexts["Hazel"].waitForExistence(timeout:5));shot("02-flock")
  a.terminate();a.launch();XCTAssertTrue(a.staticTexts["Hazel"].waitForExistence(timeout:10))
  tapTab("Journal");a.buttons["log-eggs"].tap();let eggs=a.textFields["egg-count"];XCTAssertTrue(eggs.waitForExistence(timeout:5));eggs.tap();eggs.typeText(XCUIKeyboardKey.delete.rawValue+"7");a.buttons["save-record"].tap();shot("03-egg-journal")
  tapTab("Feed");a.buttons["Add feed"].tap();let feed=a.textFields["Feed name"];XCTAssertTrue(feed.waitForExistence(timeout:5));feed.tap();feed.typeText("Layer pellets");let qty=a.textFields["Quantity (kg)"];qty.tap();qty.typeText(XCUIKeyboardKey.delete.rawValue+"25");a.buttons["save-record"].tap();XCTAssertTrue(a.staticTexts["Layer pellets"].waitForExistence(timeout:5));shot("04-feed-store")
  tapTab("Care");a.buttons["add-care"].tap();let task=a.textFields["care-name"];XCTAssertTrue(task.waitForExistence(timeout:5));task.tap();task.typeText(" - evening");a.buttons["save-record"].tap();shot("05-care-calendar")
  a.swipeUp();if a.buttons["Complete care: Collect eggs - evening"].exists {a.buttons["Complete care: Collect eggs - evening"].tap()}
  tapTab("Guide");shot("06-seasonal-guide");a.swipeUp();a.buttons["Complete layer feed"].firstMatch.tap();shot("07-offline-reference")
  a.terminate();a.launch();tapTab("Journal");XCTAssertTrue(a.staticTexts["7"].firstMatch.waitForExistence(timeout:10));shot("08-persistent-journal")
 }
 @MainActor func testPermissionFallbacks() {
  let a=XCUIApplication();a.launchArguments=["-AppleLanguages","(en)","-AppleLocale","en_US"];a.launch()
  XCTAssertTrue(a.buttons["add-bird"].waitForExistence(timeout:15));a.buttons["add-bird"].tap();a.buttons["Take bird photo"].tap()
  XCTAssertTrue(a.alerts.staticTexts["A camera is not available on this device."].waitForExistence(timeout:5));a.alerts.buttons["OK"].tap();a.buttons["Cancel"].tap()
  a.buttons["Settings"].tap();a.buttons["Enable care alerts"].tap()
  let spring=XCUIApplication(bundleIdentifier:"com.apple.springboard")
  let deny=spring.alerts.buttons.matching(NSPredicate(format:"label BEGINSWITH[c] %@","Don")).firstMatch
  if deny.waitForExistence(timeout:8){deny.tap()}
  if a.alerts.buttons["OK"].waitForExistence(timeout:3){a.alerts.buttons["OK"].tap()}
  XCTAssertTrue(a.staticTexts["Alerts are off"].waitForExistence(timeout:5))
  let p=XCTAttachment(screenshot:a.screenshot());p.name="10-permission-fallback";p.lifetime = .keepAlways;add(p)
 }
 @MainActor func testGermanLocale() {
  let a=XCUIApplication();a.launchEnvironment["COOP_QA"]="1";a.launchArguments=["-AppleLanguages","(de)","-AppleLocale","de_DE"];a.launch();XCTAssertTrue(a.staticTexts["Deine Vögel"].waitForExistence(timeout:15));let p=XCTAttachment(screenshot:a.screenshot());p.name="09-german-flock";p.lifetime = .keepAlways;add(p)
 }
}
#else
@testable import Paddock
import SwiftUI
import WidgetKit
final class N6Grain:XCTestCase {
 @MainActor func testWidgetFamilyRendering() throws {
  let now=Date()
  let rows=[H7Row(k:"bird",n:"Hazel"),H7Row(k:"egg",v:7),H7Row(k:"stock",n:"Layer pellets",v:25),H7Row(k:"care",n:"Collect eggs",d:now.addingTimeInterval(600))]
  let samples:[(WidgetFamily,CGFloat,CGFloat,String)]=[(.systemSmall,170,170,"small"),(.systemMedium,360,170,"medium"),(.systemLarge,360,376,"large"),(.accessoryRectangular,160,68,"lock-rectangle"),(.accessoryCircular,64,64,"lock-circle"),(.accessoryInline,240,28,"lock-inline")]
  for (family,width,height,name) in samples {
   let view=K3Tile(entry:K3Entry(date:now,rows:rows),sampleFamily:family).environment(\.colorScheme,.light).padding(name.hasPrefix("lock") ? 0:16).frame(width:width,height:height)
   let renderer=ImageRenderer(content:view);renderer.scale=2
   let image=try XCTUnwrap(renderer.uiImage)
   XCTAssertGreaterThan(image.size.width,0)
   let attachment=XCTAttachment(image:image);attachment.name="widget-"+name;attachment.lifetime = .keepAlways;add(attachment)
  }
 }
 func testWeekAggregationAndExclusion() {
  let now=Date();let yesterday=Calendar.current.date(byAdding:.day,value:-1,to:now)!
  let rows=[H7Row(k:"egg",d:now,v:3),H7Row(k:"egg",d:now,v:4),H7Row(k:"egg",d:yesterday,v:2),H7Row(k:"egg",d:now,v:90,gone:true),H7Row(k:"stock",v:10)]
  let week=H7Math.week(rows,now);XCTAssertEqual(week.count,7);XCTAssertEqual(week.last?.1,7);XCTAssertEqual(week.reduce(0){$0+$1.1},9)
 }
 func testRationAndBounds(){XCTAssertEqual(H7Math.ration(10,115,7),8.05,accuracy:0.0001);XCTAssertEqual(H7Math.ration(-2,115,7),0)}
 func testMergeTombstoneWins(){let old=H7Row(id:"hen",k:"bird",n:"Old",u:Date(timeIntervalSince1970:10));var newer=old;newer.u=Date(timeIntervalSince1970:20);newer.gone=true;XCTAssertEqual(H7Math.merged([old],[newer]),[newer]);XCTAssertEqual(H7Math.merged([newer],[old]),[newer])}
 func testDueIncludesOverdueExcludesCompletedAndTomorrow(){let now=Date();let past=now.addingTimeInterval(-86400);let future=now.addingTimeInterval(172800);let rows=[H7Row(k:"care",d:past),H7Row(k:"care",d:future),H7Row(k:"care",d:past,done:true)];XCTAssertEqual(H7Math.due(rows,now).count,1)}
 func testCSVQuotesAndFormulaSafety(){let r=H7Row(k:"bird",n:"=1+1",q:"a,\"b\"\nline");let csv=H7Math.csv([r]);XCTAssertTrue(csv.contains("\"'=1+1\""));XCTAssertTrue(csv.contains("\"a,\"\"b\"\"\nline\""))}
 func testPhotoRoundTrip() throws {let r=H7Row(k:"bird",n:"Hazel",p:Data([1,2,3]));let box=H7Box(rows:[r]);XCTAssertEqual(try JSONDecoder().decode(H7Box.self,from:JSONEncoder().encode(box)).rows,[r])}
 @MainActor func testDeletionScrubsContent(){let s=V2Nest();let r=H7Row(k:"bird",n:"Private QA",q:"Sensitive note",p:Data([1,2,3]));s.put(r);s.erase(r);let kept=s.z.first{$0.id == r.id};XCTAssertEqual(kept?.gone,true);XCTAssertEqual(kept?.n,"");XCTAssertEqual(kept?.q,"");XCTAssertNil(kept?.p)}
 @MainActor func testDurabilityAndRecurringCare(){let s=V2Nest();let r=H7Row(k:"care",n:"QA recurring",d:Date().addingTimeInterval(-1000),repeatDays:7);s.put(r);s.finish(r);let reopened=V2Nest();XCTAssertTrue(reopened.z.contains{$0.id == r.id && $0.done});let following=reopened.z.filter{$0.n == "QA recurring" && !$0.done && !$0.gone};XCTAssertEqual(following.count,1);XCTAssertTrue((following.first?.d ?? .distantPast) > Date());for row in reopened.z where row.n == "QA recurring"{reopened.erase(row)}}
}
#endif
