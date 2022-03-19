import 'package:flutter/material.dart';

/// 分割线
class MyDivider extends StatelessWidget {
  // 颜色
  final Color? color;
  // 高度
  final double? height;
  // 左边缩进
  final double indent;
  // 右边缩进
  final double endIndent;

  const MyDivider({
    Key? key,
    this.color = Colors.grey,
    this.height = 0.1,
    this.indent = 0,
    this.endIndent = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: height,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
