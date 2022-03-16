import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/constant/common_constant.dart';
import 'package:socialapp/util/screen_util.dart';

/// 弹出框
class DialogUtil {
  /// [确定][取消]弹窗框
  static Future okCancel(
    BuildContext context, {
    required String text,
    required VoidCallback btnOkOnPress,
  }) {
    return AwesomeDialog(
      context: context,
      title: "提示",
      desc: text,
      btnOkText: "确定",
      btnCancelText: "取消",
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: () {},
      btnOkColor: CommonConstant.primaryColor,
      btnCancelColor: Colors.brown,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      width: SU.getScreenWidth() * 0.9,
    ).show();
  }
}
