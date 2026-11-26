#!/bin/bash
set -uo pipefail
cd "$(dirname "$0")/.."
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
label="${1:-iphone}"
result="$PWD/QA/$label.xcresult"
xcrun simctl boot "$GF_SIMULATOR_UDID" || true
xcrun simctl bootstatus "$GF_SIMULATOR_UDID" -b
xcrun simctl ui "$GF_SIMULATOR_UDID" appearance light
xcodebuild -project BackyardCoop.xcodeproj -scheme Paddock -configuration FieldDebug -destination "id=$GF_SIMULATOR_UDID" -parallel-testing-enabled NO -derivedDataPath "$PWD/Artifacts/TestCompile" -resultBundlePath "$result" -jobs 2 CODE_SIGNING_ALLOWED=NO test-without-building > "QA/$label-tests.log" 2>&1
status=$?
xcrun simctl io "$GF_SIMULATOR_UDID" screenshot "QA/$label-final.png" || true
container=$(xcrun simctl get_app_container "$GF_SIMULATOR_UDID" com.backyardcoop.app data 2>/dev/null)
if [ -n "$container" ]; then cp "$container/Library/Application Support/pasture-records.json" "QA/$label-journal.json" || true; fi
xcrun xcresulttool export attachments --path "$result" --output-path "$PWD/QA/$label-screens" > "QA/$label-attachments.log" 2>&1 || true
xcrun xcresulttool get test-results summary --path "$result" > "QA/$label-summary.json" 2>/dev/null || true
printf '%s\n' "$status" > "QA/$label-exit.txt"
exit "$status"
