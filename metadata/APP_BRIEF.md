<!-- gf-brief source=f3b2ce125d3b32015e43d914f80685a3aef9239547e86d8077e5a48fc013f01b written=2026-11-26T03:55:52+03:00 -->
# Chickgandon

## What it is

Chickgandon is a flock journal for backyard chicken keepers. It lets people keep bird cards, log egg collections, track feed supplies, estimate feed needs, and schedule care. It also includes a seasonal checklist and an illustrated guide to poultry feeding and health.

## Launch and onboarding

1. On an ordinary cold launch, the app opens directly to “Flock”. The navigation bar reads “Chickgandon” and has a gear labeled “Settings” for accessibility. The cover shows the current date and “Flock”.
2. On a fresh install, “Birds”, “Weekly eggs”, and “Care due” each show zero. Under “Your birds”, the empty state reads “Make room for your flock” and “Add your first bird with a name, breed and hatch date. Your records stay on this device.”
3. Tap “Add bird” to open “Bird card”. Enter a “Name” and tap “Save” to add the first bird, or tap “Cancel” to return to “Flock”. The five tabs are “Flock”, “Journal”, “Feed”, “Care”, and “Guide”. There is no onboarding carousel, sign-in screen, or permission prompt on ordinary launch.

## Screens

### “Flock”

- The navigation title is “Chickgandon”. The dated cover reads “Flock”. “Birds” shows the number of saved bird cards and “Weekly eggs” totals all egg collections from today and the previous six days.
- “Care due” is a tappable count of unfinished reminders due today or earlier. It switches to “Care”.
- “Your birds” shows cards in name order. Each card shows the photo or first letter of the bird’s name, the name, the breed or “Breed not recorded”, and the hatch date as a relative age. Tap a card to edit it in “Bird card”.
- “Add bird” opens a new “Bird card”. The gear, labeled “Settings” for accessibility, opens “Settings”.

### “Bird card”

- “Choose bird photo” opens the system photo picker for images. “Take bird photo” opens the system camera when available and permitted. “Remove photo” appears when a photo is attached and clears the current photo from the draft.
- “Bird details” contains “Name”, “Breed”, and “Hatch date”. A new card starts with the hatch date six months earlier. The picker allows today or an earlier date. “Breed” and “Notes” are optional.
- “Cancel” discards unsaved changes. “Save” saves the card and returns to “Flock”. An existing card also offers “Delete record”.

### “Journal” — “Egg journal”

- Shows the current month and year and a “Last 7 days” ledger with a total and a row for each day. The ledger adds all collections on the same date. The history includes saved collections from any date, newest first, under “Collection date” and “Eggs”. Rows show the date, count, and any notes.
- “Log eggs” opens a new “Egg collection”. Tap a saved row to edit it in the same screen.
- “Export report” opens the system share sheet for a CSV report covering all saved journal record types, including notes. The report excludes photos.

### “Egg collection”

- “Eggs collected” contains “Collection date”, “Egg count”, and “Adjust count”. “Collection date” defaults to today and allows earlier dates. Enter a whole count or use “Adjust count” to change it by one. The count starts at zero. “Notes” is optional.
- “Cancel” discards the draft. “Save” saves the collection and returns to “Egg journal”. An existing collection also offers “Delete record”.

### “Feed” — “Feed & supplies”

- The heading reads “Good feed. Healthy hens.” Under “Ration planner”, the guidance reads “For adult laying hens on complete layer feed. Adjust to the feed label, bird condition and local advice.” Use “Birds” to set the flock size, “Grams per bird / day” to edit the daily amount per bird, and “Days” to set the period. The steppers allow 1–10,000 birds and 1–365 days. The planner starts with the saved bird count or one, “115” grams, and seven days. “Feed needed” updates immediately in “kg”. The caption reads “Baseline: 115 g per hen daily. This is a planning estimate, not a feed formulation.”
- “Feed store” shows the total as “kg in store”. “Add feed” opens a new “Feed entry”. Tap a saved row showing the feed name and amount to edit it.
- “Record feed used” appears when the total is positive and opens a sheet with the same title. “Feed used (kg)” contains the amount field, prefilled with 0.5 kg or the available total if smaller. The sheet says “The amount is deducted from your oldest feed entries first.” “Save” applies the deduction and closes the sheet. “Cancel” closes it without deducting anything.

### “Feed entry”

- Under “Feed store”, “Feed name” names the supply, “Quantity (kg)” records the amount, and “Added” sets its date. New entries start at zero kilograms and today’s date. “Notes” is optional.
- “Cancel” discards changes. “Save” saves the entry and returns to “Feed & supplies”. An existing entry also offers “Delete record”.

### “Care” — “Care calendar”

- The heading reads “Little routines,  
  lasting wellbeing.” “Add care reminder” opens a new “Care reminder”.
- The graphical “Care calendar” date picker starts on today. “Show all dates” starts on. Turn it off to limit the list to the selected date. “Include completed” starts off. Turn it on to see finished reminders.
- Reminders appear in due-date order. Each row shows the task name, due date and time, repeat interval if set, and any notes. Overdue unfinished times appear in orange. Tap the details to edit the reminder. The circle labeled “Complete care: [task name]” marks it complete. The share icon labeled “Send to Apple Reminders” sends a copy of that task to Apple Reminders.
- The caption reads “Repeating care creates the next due date when completed. Up to 60 upcoming alerts are scheduled; opening the app refreshes them.”

### “Care reminder”

- “Task name” starts as “Collect eggs”, “Due” starts one hour ahead, and “Category” starts at “Other”. Category choices are “Feeding”, “Health check”, “Egg collection”, and “Other”.
- “Repeat every (days)” accepts 0–365 days. The caption reads “0 means once. The next reminder is created when you complete this one.” “Notes” is optional.
- “Send to Apple Reminders” creates or updates a copy using the values currently in the form, including the due time, notes, and repeat interval. It can be used before saving locally. The caption reads “Sending creates or updates a copy in Apple Reminders. Your local schedule also works without access.” A successful send shows “Saved to Apple Reminders. Future edits there do not change this journal.”
- “Cancel” discards unsaved journal changes. “Save” saves locally and returns to “Care calendar”. An existing reminder also offers “Delete record”. Completing or deleting a linked journal reminder can also update or remove the copy in Apple Reminders when access is available.

### “Guide” — “Field guide”

- The heading reads “A field guide  
  for everyday care.” Under “Seasonal checklist”, “Season” starts at “Spring”. The caption reads “Choose the season where you live. Checks are kept for the current year.” Tap a season to switch lists and tap any task to check or uncheck it.
  - “Spring” offers “Deep clean the coop”, “Inspect birds and bedding”, and “Check predator barriers”.
  - “Summer” offers “Check shade and water”, “Inspect for mites”, and “Keep feed cool and dry”.
  - “Autumn” offers “Check shelter for drafts”, “Inspect roof and fencing”, and “Review feed supplies”.
  - “Winter” offers “Keep drinking water unfrozen”, “Keep bedding dry”, and “Check ventilation daily”.
- “Search the guide” filters the library by matching the article title or body. Under “Feed & health library”, tap “Complete layer feed”, “Everyday biosecurity”, “Respiratory warning signs”, “Mites and parasites”, “Changes in laying”, or “Sudden illness in the flock” to open that article.
- Article screens retain the navigation title “Field guide” and show the article’s title and text. “Read the source” under “Reference” opens the external reference. The system back control returns to the guide.

### “Settings”

- Under “Care notifications”, the text reads “Get a local alert at each care time. Permission is optional and can be changed in device Settings.” “Enable care alerts” requests permission for local notifications. The status reads “Alerts enabled” or “Alerts are off”. “Open device Settings” opens the app’s page in iOS Settings.
- “Export file” opens the system save picker for a complete journal copy, including bird photos. “Import file” opens the system file picker for a compatible journal export. Import merges it with the current journal and keeps the newer edit when the same record exists in both. Success shows “File imported”.
- Under “Your data”, “Export report” opens the system share sheet for the CSV report. “Privacy & app information” opens “Privacy”. “Done” dismisses “Settings”. The footer displays “Chickgandon” and “1.4.2 · 482”.

### “Privacy”

The screen reads “No ads, purchases, analytics or tracking. Flock photos, notes and care records stay on your device. Choose a file to open, or send a copy directly to someone. Changes stay on this device until you share again. Apple Reminders receives only care items you choose to send. Shared reports are controlled by you. Delete any record from its edit screen. No account is required. The field guide is educational and does not diagnose illness; contact a poultry veterinarian for sick birds.” The system back control returns to “Settings”.

### Home Screen and Lock Screen widgets

The widget gallery shows “Chickgandon” with “Egg totals, feed supplies and the care your flock needs today.” The small Home Screen widget shows “Weekly eggs” with a total and chart and opens “Journal” when tapped. The medium widget shows “Care today”, a due count, the first due task or “No care due”, and the egg chart. The large widget shows “Chickgandon”, “Birds”, “Feed store”, “Care due”, the egg chart, and up to three unfinished tasks under “Care calendar”, or “No care due”. Lock Screen variants show “Care due” and a count, a calendar icon and count, or “Care today” and a count with “reminders”. The medium, large, and Lock Screen widgets open “Care”.

## Features

- “Your birds” and “Bird card” for individual flock records with a name, breed, hatch date, photo, and notes.
- “Egg journal”, “Log eggs”, “Last 7 days”, and “Weekly eggs” for collection history and daily and weekly totals.
- “Ration planner” for estimating feed needed in kilograms, plus “Feed store”, “Add feed”, and “Record feed used” for inventory.
- “Care calendar” with date and completion filters, one-time or repeating reminders, and optional local care alerts.
- “Send to Apple Reminders” for selected care items.
- “Seasonal checklist” with yearly progress and a searchable “Feed & health library” with source links.
- “Export report” for sharing a CSV, “Export file” and “Import file” for complete journal copies, and “Delete record” for individual entries.
- “Chickgandon” widgets for egg totals, feed supplies, and care due.

## Behaviours that can look like bugs

- **Empty bird list.** “Make room for your flock” and “Add your first bird with a name, breed and hatch date. Your records stay on this device.” remain until the first bird is saved. “Save” requires a nonblank “Name” and is briefly disabled while a selected photo loads. “Hatch date” cannot be in the future.
- **Empty egg history.** “Your egg diary starts here” and “Record each collection. The chart totals all collections for each day.” remain until a collection is saved. “Save” requires a whole “Egg count” from 0 through 100,000 and a “Collection date” of today or earlier. Each use of “Log eggs” adds a collection, including on dates already logged. Open an existing row to change it. The seven-day total rolls forward with the date.
- **Planner validation.** “Feed needed” is replaced by “Enter 1–500 grams” for an invalid calculation value. Enter a positive number no greater than 500 in “Grams per bird / day”. The bird count is refreshed from the flock when the screen appears.
- **Empty or depleted feed store.** “Keep an eye on supplies” and “Add the feed you have in storage, then record what you use.” appear before the first feed entry. “Save” in “Feed entry” requires a nonblank “Feed name” and “Quantity (kg)” from 0 through 100,000. “Record feed used” requires positive stock. In that sheet, “Save” requires an amount greater than zero and no greater than the total. Deduction starts with the oldest entries, and depleted entries stay visible at zero until deleted.
- **Care filters and completion.** “A little care goes a long way” and “Plan feeding, egg collection or a health check. Alerts are optional; the calendar always works offline.” can mean the current filters match no reminders. Tap “Add care reminder”, choose another date, turn on “Show all dates”, or turn on “Include completed” as appropriate. “Save” and “Send to Apple Reminders” in the editor require a nonblank “Task name”. A completed reminder disappears under the default filter. With “Include completed” on, its completion control is disabled. Completing a repeating reminder keeps the completed entry and creates the next occurrence at the first scheduled date still in the future.
- **Alerts and Apple Reminders.** Only the next 60 future unfinished care reminders get local alerts, with the task name and “Your flock care is due.” If permission is declined, the app says “Notifications are off. Care stays in the app; you can enable alerts in Settings.” If the permission request fails, it says “Notifications are unavailable. Care stays saved locally.” For Apple Reminders, “Reminders access was declined. Your care schedule remains available here.” means access must be allowed to send a copy. “Create a list in Apple Reminders first.” means a list is needed before retrying. A failed send can show “Could not write to Apple Reminders. Your local care record is safe.”
- **Photo problems.** “A camera is not available on this device.” means “Choose bird photo” is the available alternative. “Camera access is off. Choose a photo or enable the camera in device Settings.” gives the two recovery options. If “This photo could not be opened.” appears, choose another image.
- **Guide search and yearly checklist.** A search with no matches leaves “Feed & health library” without article rows. Clear “Search the guide” to restore them. The checklist remembers checks for each season in the current year and starts unchecked for a new year.
- **Deletion and import.** “Delete record” appears only for saved entries. It opens “Delete this record?” and requires tapping “Delete record” again. “Import file” expects a compatible Chickgandon journal export. Use a complete export from “Export file” if the picker or import reports an error. Error wording comes from the system.
- **Journal errors.** App alerts use “Chickgandon” with “OK”. Possible messages include “Could not read the local journal. Your file was kept.”, “Could not save. Please check available device storage.”, and “Could not create the report.” If a save fails, check device storage and verify that the entry appears before relying on it.

## Starter content and resume

No sample birds, egg collections, feed entries, or saved care reminders are included on a normal first launch. The six guide articles and four seasonal checklists are built in. “Collect eggs” is a default in a new reminder form and appears in the calendar only after saving. Saved records and checklist checks are available after relaunch and can be edited. Unsaved drafts cannot be resumed after dismissal or a fresh launch.

## Permissions

The quoted usage descriptions below are the English versions.

- **Camera.** First requested when the user taps “Take bird photo” on a device with an available camera and permission has yet to be decided. “Take a portrait to recognize a bird in your flock journal.”
- **Apple Reminders.** Full access is requested when the user taps “Send to Apple Reminders”. “Save and update the poultry care tasks you choose in Apple Reminders.” The app also declares the older usage description “Copy selected poultry care tasks into your Apple Reminders lists.” The supported iOS versions use the full-access request.
- **Notifications.** Requested from “Enable care alerts” in “Settings”. iOS supplies the prompt wording. The app has no custom usage-description string for this permission.
- “Choose bird photo” uses the system picker for individual images and does not request broad photo-library access. The app declares “Choose an existing bird picture for its flock card.” for photo-library access.

## Absent

Login and app accounts, in-app purchases, ads, analytics, an account deletion flow, and an App Tracking Transparency prompt are absent. Users can create private journal records, notes, and bird photos. There is no public posting, community feed, or in-app exchange of user-generated content.

## Data and support

Journal data stays on the device by default. There is no automatic cloud sync. Users can choose where to save or share a complete journal copy, share a CSV report, or send selected care items to Apple Reminders. Import merges a selected journal copy into the local journal. There is no on-screen “Contact” or “Support” control.

## Scanning and health

The app does not scan barcodes or QR codes. The camera takes bird-card photos. “Feed & health library” contains educational poultry information on layer feed, biosecurity, respiratory warning signs, mites and parasites, changes in laying, and sudden flock illness. It does not diagnose illness, assess individual products, or provide human health information. Every article has a “Reference” section with “Read the source” linking to the relevant Alabama Cooperative Extension, University of Minnesota Extension, Merck Veterinary Manual, or Minnesota Board of Animal Health reference.

## Platform

iPhone and iPad are supported with a minimum of iOS 17.4 or iPadOS 17.4. iPhone supports portrait and both landscape orientations. iPad also supports upside-down portrait. The app uses a light appearance.

The quoted app labels in this brief are English. The app also localizes text in German, French, and Brazilian Portuguese. Dates and numeric input follow device locale where the system formats them. Feed quantities are metric. The checklist season is chosen manually, and there is no region gate or location permission.

## Category

Lifestyle
