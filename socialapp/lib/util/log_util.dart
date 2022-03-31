import 'dart:convert';

import 'package:flutter/foundation.dart';

/// 日志打印工具类
class LogUtil {
  static void p(Object? info) {
    if (kDebugMode) {
      debugPrint("suiz | ${json.encode(info)}");
    }
  }
}
