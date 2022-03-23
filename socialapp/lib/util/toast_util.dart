import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/util/screen_util.dart';

/// 弹窗消息提示
class ToastUtil {
  /// 弹出消息
  static void show({
    required String msg,
    Color bColor = Colors.black,
    Color textColor = Colors.white,
    double fontSize = 36,
    ToastGravity position = ToastGravity.CENTER,
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    // 先取消之前显示的Toast
    Fluttertoast.cancel();

    // 根据消息长度决定自动消失时间(只对ios生效)
    double multiplier = 0.5;
    double flag = msg.length * 0.06 + 0.5;
    int timeInSecForIos = (multiplier * flag).ceil();

    // 显示Toast
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: bColor,
      textColor: textColor,
      fontSize: SU.setFontSize(fontSize),
      toastLength: toastLength,
      gravity: position,
      timeInSecForIosWeb: timeInSecForIos,
    );
  }
}
