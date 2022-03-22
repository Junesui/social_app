import 'package:flutter/material.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_divider.dart';

/// 表单输入框
class MyInput extends StatelessWidget {
  // 是否有底部边框
  final bool isHasBottomLine;
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
  // 自动获取焦点
  final bool autofocus;
  // 焦点节点
  final FocusNode? focusNode;
  // 输入改变回调
  final ValueChanged<String>? onChanged;
  // 输入内容最大长度
  final int? maxLength;
  // 计数文字的样式
  final TextStyle? counterStyle;
  // 内容内边距是否设为0
  final bool isCollapsed;
  // 最大行数 不设置的话只有一行
  final int? maxLines;

  const MyInput({
    Key? key,
    this.isHasBottomLine = true,
    this.hintText,
    this.fontSize = 32,
    this.controller,
    this.isObscure = false,
    this.keyboardType,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.maxLength,
    this.counterStyle,
    this.isCollapsed = false,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 输入区域
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          onChanged: onChanged,
          obscureText: isObscure,
          keyboardType: keyboardType,
          autofocus: autofocus,
          focusNode: focusNode,
          cursorWidth: 2,
          cursorColor: StyleConstant.primaryColor,
          cursorRadius: const Radius.circular(10),
          textAlignVertical: TextAlignVertical.bottom,
          minLines: 1,
          maxLines: maxLines,
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
            counterStyle: counterStyle,
            isCollapsed: isCollapsed,
          ),
        ),
        // 底边框
        isHasBottomLine ? const MyDivider() : const SizedBox(),
      ],
    );
  }
}
