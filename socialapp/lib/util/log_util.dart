import 'package:flutter/foundation.dart';

/// 日志打印工具类
class LogUtil {
  static void p(String message) {
    if (kDebugMode) {
      debugPrint("suiz | $message");
    }
  }
}
