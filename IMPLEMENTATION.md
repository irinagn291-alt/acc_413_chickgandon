# Chickgandon

Open `BackyardCoop.xcodeproj`, scheme `Paddock`. Minimum iOS/iPadOS 17.4. Native SwiftUI, no external dependencies. Four app files, one WidgetKit file and one test file (six Swift source files total). One application target, one required widget extension and two test bundles.

Bird cards support names, breeds, hatch dates, notes, local photo selection and camera capture. Photos are resized to 640 pixels and kept with their cards. Egg collections support create/edit/delete, daily aggregation and a seven-day chart. The iPad journal uses the available full content width. Feed planning uses flock count, editable grams and days; stock supports additions, corrections and deduction from oldest entries. It applies to adult laying hens, not a formulation for chicks or mixed species.

Care supports date/time, category, notes, completion, deletion, calendar filtering and recurrence after completion. Local notifications are opt-in after an explanation. At most 60 future alerts are scheduled and refreshed on app activation and edits. Apple Reminders is an explicit export/update, not bidirectional synchronization; denial preserves the local calendar. The bundled health/feed library and annual seasonal checklists work without network access. CSV exports use system sharing, quote multiline text and protect against spreadsheet formula injection.

JSON is written atomically to Application Support before widgets or iCloud are updated. A failed decode preserves an additional copy of the original file. Widgets read a photo-free App Group snapshot. Small, medium, large, accessory circular, rectangular and inline families are provided; their timeline includes the next local midnight. There are no fake starting entries. UI tests create clearly identifiable QA records through real forms.

Optional CloudKit sync uses a private custom record zone and a CKAsset per record, with per-record timestamps and persistent deletion markers. Deleting a record clears its name, notes, photo and other content before retaining the marker. Each sync fetches all zone changes and merges before upload; a failed upload remains local for retry. An iCloud account change pauses sync to prevent mixing journals. There is no app server, public user content or external data API. All runtime network traffic is optional Apple CloudKit.

## SDK decisions

- WidgetKit requires an extension, so the one-target guideline is interpreted as one application target. Test bundles do not ship.
- The individual brief explicitly excludes Live Activities. No ActivityKit target, declaration or timer is fabricated.
- EventKit uses iOS 17 `requestFullAccessToReminders()` with the current `NSRemindersFullAccessUsageDescription`, plus the requested legacy description. No calendar permission is requested. https://developer.apple.com/documentation/eventkit/accessing-the-event-store
- PhotosPicker uses the system photo selector and does not require broad photo-library access. Camera access is requested only by its button. The app never saves to the system photo library, so it does not request add-only photo permission.
- Push entitlement and `remote-notification` mode are declared as required. The product schedules local notifications; it does not register for or promise server-driven alerts.
- CloudKit private records consume the user's iCloud quota; asset fields avoid putting journal/photo payload into the 1 MB ordinary-record limit. https://developer.apple.com/documentation/cloudkit/ckcontainer and https://developer.apple.com/documentation/cloudkit/ckasset

## Content and privacy

EN, DE, FR and PT-BR cover UI, widget text, guide content, privacy descriptions and store metadata. No analytics, advertising, ATT, payment or third-party SDK is included. Photos and journal information are local unless private iCloud sync is enabled or the user shares them. Privacy text is available inside Settings. No account, UGC or profile system exists. Educational poultry notes avoid diagnosis and drug instructions.

Reference links are included in the guide; the explanatory text is bundled and written for this app. Feeding baseline: Alabama Cooperative Extension, *Feeding the Laying Hen* (about 100–150 g daily; calculator default 115 g). Other references: University of Minnesota Extension, Merck Veterinary Manual and Minnesota Board of Animal Health. The guide does not claim current outbreak data.

## Artwork

`Resources/PastureArt.xcassets/NestMark.appiconset/NestMark.png` is the delivered icon, generated using the built-in imagegen tool. Its prompt: “iOS app icon, square full bleed; cream notebook with a simple green egg-production chart and a white hen at its lower corner; yellow #FFD400 background, green #7CB518, charcoal #2B2B2B details and orange #FF8C42 beak; clean utility illustration, large shapes; no text, numbers, watermark or brand references.” The original is preserved in `Resources/icon-original.png`. The notebook, chart and farm bird fit the supplied brief; no campaign marks or brand assets were used.

## Build and QA

See `QA/` for complete logs, `.xcresult` bundles, exported screenshots and persisted journal evidence. Generic simulator builds can run directly. All foreground simulator tests must run through the repository's `gf/genesis/simulator_pool.py` with `QA/foreground.sh`; the script uses only `$GF_SIMULATOR_UDID` for device commands and disables parallel testing. `QA/archive.sh` creates an unsigned local release archive and maps source paths out of compiler debug information. Signing, distribution and publication are not performed.

## Signing handoff

Bundle: `com.backyardcoop.app`; extension: `.glance`; App Group: `group.com.backyardcoop.app`; CloudKit container: `iCloud.com.backyardcoop.app`. A real Apple Developer team must register and provision these identifiers, enable the declared capabilities and deploy the `PasturePage` schema before a signed production distribution. End-to-end iCloud synchronization and physical camera capture cannot be validated without that account/device setup. Local operation does not depend on either.
