#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
xcodebuild -project BackyardCoop.xcodeproj -scheme Paddock -configuration OrchardRelease -destination 'generic/platform=iOS' -derivedDataPath "$PWD/Artifacts/ReleaseBuild" -archivePath "$PWD/Artifacts/BackyardCoop.xcarchive" -resultBundlePath "$PWD/QA/release-$(date -u +%Y%m%dT%H%M%S).xcresult" -jobs 2 CODE_SIGNING_ALLOWED=NO GCC_GENERATE_DEBUGGING_SYMBOLS=NO "OTHER_SWIFT_FLAGS=\$(inherited) -debug-prefix-map $PWD=." "OTHER_CFLAGS=\$(inherited) -fdebug-prefix-map=$PWD=." archive > QA/archive.log 2>&1
