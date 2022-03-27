import 'dart:io';

import 'package:dio/dio.dart';
import 'package:socialapp/net/api.dart';
import 'package:socialapp/net/http/http_util.dart';
import 'package:socialapp/util/compress_util.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 投稿相关请求
class PostDao {
  // 投稿
  static Future post(int type, String text, List<AssetEntity> entities) async {
    List uploadFiles = [];
    for (var entity in entities) {
      if (await entity.exists) {
        File? compressFile = await CompressUtil.imageCompressAndGetFile(await entity.file);
        if (compressFile == null) {
          break;
        } else {
          String path = compressFile.absolute.path;
          String filename = path.substring(path.lastIndexOf("/") + 1, path.length);
          MultipartFile file = await MultipartFile.fromFile(path, filename: filename);
          uploadFiles.add(file);
        }
      }
    }
    return await HttpUtil.postWithFiles(Api.post, {
      "type": type,
      "text": text,
      "files": uploadFiles,
    });
  }
}
