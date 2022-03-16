import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/util/screen_util.dart';

/// 弹窗消息提示
class ToastUtil {
  /// 弹出消息
  static Future show({
    required String msg,
    Color bColor = Colors.black,
    Color textColor = Colors.white,
    double fontSize = 36,
    ToastGravity position = ToastGravity.CENTER,
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: bColor,
      textColor: textColor,
      fontSize: SU.setFontSize(fontSize),
      toastLength: toastLength,
      gravity: position,
      timeInSecForIosWeb: 1,
    );
  }
}
