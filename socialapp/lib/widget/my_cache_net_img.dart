import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/constant/common_constant.dart';

/// 缓存网络图片
class MyCacheNetImg extends StatelessWidget {
  final String imgUrl;
  final BoxFit? fit;

  const MyCacheNetImg({Key? key, required this.imgUrl, this.fit = BoxFit.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fit: fit,
      // 占位符
      placeholder: (context, url) => _buildPlaceholder(),
      // 错误时候占位符
      errorWidget: (context, url, error) => _buildPlaceholder(),
    );
  }

  // 占位符
  SizedBox _buildPlaceholder() {
    return SizedBox(
      child: Image.asset(
        CommonConstant.avatarPlaceholder,
        fit: BoxFit.cover,
      ),
    );
  }

  /// 图片缓存的提供器
  static ImageProvider provider(String imgUrl) {
    if (imgUrl.isNotEmpty) {
      return CachedNetworkImageProvider(imgUrl);
    } else {
      return const AssetImage(CommonConstant.avatarPlaceholder);
    }
  }
}
