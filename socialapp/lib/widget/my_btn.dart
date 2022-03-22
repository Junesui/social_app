import 'package:flutter/material.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/util/screen_util.dart';

/// 按钮
class MyBtn extends StatelessWidget {
  // 点击事件
  final VoidCallback? onPressed;
  // 按钮里面的内容
  final Widget? child;
  // 按钮宽度
  final double? width;
  // 内边距
  final EdgeInsetsGeometry? padding;
  // 按钮颜色
  final Color? color;

  const MyBtn({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width,
    this.padding,
    this.color = StyleConstant.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SU.setHeight(100))),
          padding: padding,
        ),
      ),
    );
  }
}
