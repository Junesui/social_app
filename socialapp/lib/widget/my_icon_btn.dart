import 'package:flutter/material.dart';
import 'package:socialapp/util/screen_util.dart';

/// 图标按钮
class MyIconBtn extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double size;
  final Color? color;
  const MyIconBtn({
    Key? key,
    required this.onTap,
    required this.icon,
    this.size = 60,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: color,
        size: SU.setFontSize(size),
      ),
    );
  }
}
