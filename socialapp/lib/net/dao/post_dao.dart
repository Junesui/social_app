import 'package:dio/dio.dart';
import 'package:socialapp/net/api.dart';
import 'package:socialapp/net/http/http_util.dart';
import 'package:socialapp/util/compress_util.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 发布相关请求
class PostDao {
  // 发布
  static Future post(int type, String text, List<AssetEntity> files) async {
    List uploadFiles = [];
    for (var f in files) {
      if (await f.exists) {
        MultipartFile file = await MultipartFile.fromFile(
            (await CompressUtil.imageCompressAndGetFile((await f.file)!))!.absolute.path);
        uploadFiles.add(file);
      }
    }
    return await HttpUtil.postWithFiles(Api.post, {
      "type": type,
      "text": text,
      "files": uploadFiles,
    });
  }
}
