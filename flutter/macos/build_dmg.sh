#!/bin/sh
test -f 静远理财.dmg && rm 静远理财.dmg
create-dmg \
  --volname "静远理财" \
  --icon-size 50 \
  --window-size 1000 400 \
  --icon "静远理财.app" 50 50 \
  --hide-extension "静远理财.app" \
  "静远理财.dmg" \
  "/Users/xieqiang/创业项目/flutter/build/macos/Build/Products/Release"

#"Application-Installer.dmg"是.dmg文件名称。
#"source_folder/"是"flutter build macos --release"结果路径，如：/工程目录/build/macos/Build/Products/Release/xxx.app