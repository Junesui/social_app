import 'package:flutter/material.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_text.dart';

/// showModalBottomSheet 的内容
class MyBottomSheet extends StatelessWidget {
  // 内容
  final List<BottomSheetParam> params;

  const MyBottomSheet({Key? key, required this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: SU.setWidth(32), bottom: SU.setHeight(50)),
      child: Column(
        children: params.map<Widget>((param) {
          return _buildMoreBottomSheetItem(param.onTap, param.icon, param.text);
        }).toList(),
      ),
    );
  }

  /// 子项内容
  _buildMoreBottomSheetItem(VoidCallback onTap, IconData icon, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: SU.setHeight(60)),
        child: Row(
          children: [
            // 图标
            Icon(
              icon,
              color: Colors.grey,
              size: SU.setFontSize(60),
            ),
            // 间隔
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 15),
              child: SizedBox(
                width: SU.setWidth(50),
              ),
            ),
            // 文字
            MyText(
              text: text,
              fontSize: 45,
            )
          ],
        ),
      ),
    );
  }
}

/// 底部弹窗的子项参数
class BottomSheetParam {
  VoidCallback onTap;
  IconData icon;
  String text;

  BottomSheetParam({required this.onTap, required this.icon, required this.text});
}
