#!/bin/bash
fvm flutter clean
fvm flutter pub get
# fvm flutter gen-l10n
if [ "$1" = "--android" ]; then
  fvm flutter build apk
elif [ "$1" = "--ios" ]; then
  cd ios && pod install && open Runner.xcworkspace
elif [ "$1" = "--web" ]; then
  fvm flutter build web
fix