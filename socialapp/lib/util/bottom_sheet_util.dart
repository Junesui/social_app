import 'package:flutter/material.dart';
import 'package:socialapp/widget/my_text.dart';

/// 底部弹窗
class BottomSheetUtil {
  static show(BuildContext context, List<BottomSheetParam> params) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ...params.map<Widget>((param) {
                  return _buildBottomSheetItem(
                    param.onTap,
                    param.text,
                    (params.indexOf(param) + 1) != params.length,
                  );
                }).toList(),
                _buildCancel(context),
              ],
            ),
          );
        });
  }

  /// 底部弹窗的内容子项
  static _buildBottomSheetItem(VoidCallback? onTap, String text, bool isHasDivide) {
    return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            // 文字
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: text,
                  fontSize: 46,
                ),
              ],
            ),
            // 分割线
            Divider(
              color: Colors.grey,
              height: 32,
              thickness: isHasDivide ? null : 8,
            )
          ],
        ));
  }

  /// 取消 文字
  static _buildCancel(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: MyText(
                text: "取消",
                color: Colors.red,
                fontSize: 46,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 底部弹窗的子项参数
class BottomSheetParam {
  String text;
  VoidCallback? onTap;

  BottomSheetParam({required this.text, this.onTap});
}
