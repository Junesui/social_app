import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 发布图片时候的图片展示组件
class PostImgCell extends StatefulWidget {
  // 图片列表
  final List<AssetEntity> imgs;

  const PostImgCell({Key? key, required this.imgs}) : super(key: key);

  @override
  _PostImgCellState createState() => _PostImgCellState();
}

class _PostImgCellState extends State<PostImgCell> {
  @override
  Widget build(BuildContext context) {
    double height = SU.setHeight(360);
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: SU.setWidth(StyleConstant.mainLRPadding),
        vertical: 20,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.imgs.length,
        itemBuilder: (context, index) {
          return _buildImgItem(height, context, index);
        },
      ),
    );
  }

  /// 图片子项
  _buildImgItem(double height, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: SizedBox(
        height: height,
        width: height,
        child: Stack(
          children: [
            // 图片
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouterName.postImgPreview,
                  arguments: {"imgs": widget.imgs, "index": index},
                );
              },
              child: SizedBox(
                height: height,
                width: height,
                child: Image(
                  image: AssetEntityImageProvider(
                    widget.imgs[index],
                    isOriginal: false,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 删除按钮
            _buildBtn(Alignment.topRight, Icons.close, () {
              setState(() {
                widget.imgs.removeAt(index);
              });
            }),
            // 编辑按钮
            _buildBtn(Alignment.bottomRight, Icons.edit, () {
              _cropImg(widget.imgs[index], index);
            }),
          ],
        ),
      ),
    );
  }

  /// 图片上的按钮
  _buildBtn(Alignment alignment, IconData icon, VoidCallback ontap) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: CircleAvatar(
          radius: SU.setHeight(32),
          backgroundColor: Colors.grey,
          child: MyIconBtn(
            onTap: ontap,
            icon: icon,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// 图片裁剪
  _cropImg(AssetEntity img, int index) async {
    // 裁剪
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: await img.originFile.then((file) => file?.path ?? ""),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: '图片编辑',
        toolbarColor: Colors.yellow,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
    );

    // 显示裁剪后的图片
    final String path = croppedFile?.path ?? "";
    if (path.isNotEmpty) {
      final AssetEntity? fileEntity = await PhotoManager.editor.saveImageWithPath(
        path,
        title: path.substring(path.lastIndexOf("/") + 1),
      );
      if (fileEntity != null) {
        setState(() {
          widget.imgs.replaceRange(index, index + 1, [fileEntity]);
        });
      }
    }
  }
}
