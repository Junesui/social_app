import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储工具类
class StorageUtil {
  // 保存字符串
  static Future<bool> setString(String k, Object v) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(k, json.encode(v));
  }

  // 获取字符串
  static Future<String> getString(String k) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(k) ?? "";
  }

  // 移除
  static Future<bool> remove(String k) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(k);
  }
}
