import 'package:flutter/material.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_divider.dart';

/// 表单输入框
class MyInput extends StatelessWidget {
  // 输入框内提示文字
  final String? hintText;
  // 文字大小
  final double fontSize;
  // 控制器
  final TextEditingController? controller;
  // 是否密码输入
  final bool isObscure;
  // 键盘类型
  final TextInputType? keyboardType;
  // 输入改变回调
  final ValueChanged<String>? onChanged;

  const MyInput({
    Key? key,
    this.hintText,
    this.fontSize = 32,
    this.controller,
    this.isObscure = false,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 输入区域
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          cursorWidth: 2,
          cursorColor: StyleConstant.primaryColor,
          cursorRadius: const Radius.circular(10),
          textAlignVertical: TextAlignVertical.bottom,
          style: TextStyle(
            fontSize: SU.setFontSize(fontSize),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: SU.setFontSize(fontSize),
            ),
          ),
          onChanged: onChanged,
        ),
        // 底边框
        const MyDivider(),
      ],
    );
  }
}
