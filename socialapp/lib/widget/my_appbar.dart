import 'package:flutter/material.dart';
import 'package:socialapp/constant/common_constant.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:socialapp/widget/my_text.dart';

/// AppBar
class MyAppBar extends AppBar {
  // 标题
  final String mTitle;
  // 标题大小
  final double fontSize;
  // 右侧 Icon
  final IconData? actionIcon;
  // 右侧 Icon 的颜色
  final Color? actionColor;
  // 右侧 Icon 大小
  final double? actionIconSize;
  // 右侧 Icon 点击事件
  final VoidCallback? actionIconOnTap;

  MyAppBar({
    Key? key,
    required this.mTitle,
    this.fontSize = 46,
    this.actionIcon,
    this.actionColor,
    this.actionIconSize,
    this.actionIconOnTap,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: MyIconBtn(
        onTap: () {
          Navigator.of(context).pop();
        },
        icon: Icons.arrow_back_ios,
      ),
      title: MyText(
        text: widget.mTitle,
        fontSize: widget.fontSize,
      ),
      centerTitle: true,
      actions: widget.actionIcon == null
          ? null
          : [
              Padding(
                padding: EdgeInsets.only(right: SU.setWidth(CommonConstant.mainLRPadding)),
                child: MyIconBtn(
                  onTap: widget.actionIconOnTap ?? () {},
                  icon: widget.actionIcon ?? Icons.block,
                  size: widget.actionIconSize ?? 150,
                  color: widget.actionColor,
                ),
              ),
            ],
      elevation: 0,
    );
  }
}
