import 'package:flutter/material.dart';
import 'package:socialapp/util/screen_util.dart';

/// 自定义text
class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  const MyText({
    Key? key,
    required this.text,
    this.fontSize = 32,
    this.fontWeight,
    this.color,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: SU.setFontSize(fontSize),
        fontWeight: fontWeight,
        overflow: overflow,
        decoration: decoration,
      ),
    );
  }
}
