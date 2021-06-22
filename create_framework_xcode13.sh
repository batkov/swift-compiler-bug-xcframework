#!/bin/sh

which xcbeautify || brew install xcbeautify

set -o pipefail

xcodebuild \
  -project bug.xcodeproj \
  -scheme Component \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 11,OS=15.0' \
  | xcbeautify || exit 1

rm -rf build

xcodebuild archive \
    -project bug.xcodeproj \
    -scheme Component \
    -archivePath "build/ios.xcarchive" \
    -sdk iphoneos \
    SKIP_INSTALL=NO \
    | xcbeautify
xcodebuild archive \
    -project bug.xcodeproj \
    -scheme Component \
    -archivePath "build/ios_sim.xcarchive" \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO \
    | xcbeautify

rm -rf /Component.xcframework

xcodebuild -create-xcframework \
    -framework "build/ios.xcarchive/Products/Library/Frameworks/Component.framework" \
    -framework "build/ios_sim.xcarchive/Products/Library/Frameworks/Component.framework" \
    -output "build/Component.xcframework" \
    | xcbeautify