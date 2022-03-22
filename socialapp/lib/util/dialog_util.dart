import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/util/screen_util.dart';

/// 弹出框
class DialogUtil {
  /// [确定][取消]弹窗框
  static Future okCancel(
    BuildContext context, {
    String title = "提示",
    required String text,
    required VoidCallback btnOkOnPress,
  }) {
    return AwesomeDialog(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      context: context,
      title: title,
      desc: text,
      btnOkText: "确定",
      btnCancelText: "取消",
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: () {},
      btnOkColor: StyleConstant.primaryColor,
      btnCancelColor: Colors.brown,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      width: SU.getScreenWidth() * 0.9,
    ).show();
  }
}
