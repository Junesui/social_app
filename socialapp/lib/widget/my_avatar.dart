import 'package:flutter/material.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/util/toast_util.dart';
import 'package:socialapp/widget/my_cache_net_img.dart';

/// 公共头像组件
class MyAvatar extends StatelessWidget {
  // 用户ID
  final int userId;
  // 用户头像URL
  final String? avatarUrl;
  // 头像半径
  final double radius;
  // 显示房主图片
  final bool isShowOwnerIcon;

  const MyAvatar({
    Key? key,
    required this.userId,
    required this.avatarUrl,
    this.radius = 52,
    this.isShowOwnerIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ToastUtil.show(msg: "TODO 跳转到用户信息页");
      },
      child: Stack(
        children: [
          // 头像
          CircleAvatar(
            backgroundImage: MyCacheNetImg.provider(avatarUrl ?? ""),
            backgroundColor: Colors.grey[200],
            radius: SU.setHeight(radius),
          ),
          // 房主图标
          isShowOwnerIcon ? _buildOwnerIcon() : const SizedBox(),
        ],
      ),
    );
  }

  /// 房主图标
  _buildOwnerIcon() {
    return Positioned(
      left: SU.setWidth(30),
      child: CircleAvatar(
        radius: SU.setHeight(22),
        backgroundColor: StyleConstant.primaryColor,
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: SU.setFontSize(28),
        ),
      ),
    );
  }
}
