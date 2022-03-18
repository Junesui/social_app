import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/constant/common/asset_constant.dart';
import 'package:socialapp/util/screen_util.dart';

/// 内容加载出来之前的加载框
class MyLoadingContainer extends StatelessWidget {
  // 子组件
  final Widget child;
  // 加载状态
  final bool isLoading;

  const MyLoadingContainer({Key? key, required this.child, this.isLoading = false})
      : super(key: key);

  // 加载动画
  get _buildLoading {
    return Center(
      child: SizedBox(
        width: SU.getScreenWidth() / 3,
        child: Lottie.asset(AssetConstant.loadingAnimation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? _buildLoading : child;
  }
}
