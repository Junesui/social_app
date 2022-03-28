import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/constant/common/asset_constant.dart';
import 'package:socialapp/widget/my_text.dart';

/// 遮罩层
class MyMaskLayer extends StatelessWidget {
  // 是否显示
  final bool isShow;
  // 提示文字
  final String? hintText;
  // 子组件
  final Widget child;

  const MyMaskLayer({Key? key, required this.child, required this.isShow, this.hintText})
      : super(key: key);

  // 带遮罩层
  get _buildWithMaskLayer {
    return Scaffold(
      body: Stack(
        children: [
          // 子组件
          child,
          // 遮罩层
          Container(
            color: Colors.black12,
            child: Center(
              child: Container(
                width: 72,
                height: 72,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 动画
                    Expanded(child: Lottie.asset(AssetConstant.loadingAnimation)),
                    // 提示文字
                    MyText(
                      text: hintText ?? "",
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isShow ? _buildWithMaskLayer : child;
  }
}
