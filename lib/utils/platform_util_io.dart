import 'dart:io';
import 'package:flutter/foundation.dart';

void initTargetPlatform() {
  print('initTargetPlatform io');
  if (Platform.isAndroid || Platform.isIOS) {
    return;
  }
  // https://github.com/google/flutter-desktop-embedding  3e21f6b
  // https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
}

/// 目前 desktop 工程模版在 macOS 上默认是不能访问网络的
/// 需要在「macos/Runner/DebugProfile.entitlements」中追加如下代码
/// <key>com.apple.security.network.client</key><true/>