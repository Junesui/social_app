import 'package:flutter/material.dart';

/// 公共常量
class CommonConstant {
  /// ******************** 资源路径常量 ********************
  // 头像占位符
  static const String avatarPlaceholder = "assets/images/avatar_placeholder.jpg";
  // 页面加载出来之前的动画
  static const String loadingAnimation = "assets/animation/loading_button.json";
  // 房主等待用户加入时候的背景动画
  static const String waitingRipple = "assets/animation/waiting_ripple.json";

  /// ******************** 样式常量 ********************
  // app 主色调
  static const Color primaryColor = Colors.orangeAccent;

  // app 页面主要内容左右内边距
  static const double mainLRPadding = 40;

  // 内容距离状态栏的距离
  static const double fromStateBar = 5;
}
