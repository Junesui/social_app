import 'package:socialapp/net/api.dart';
import 'package:socialapp/net/http/http_util.dart';

/// 全局通用
class CommonDao {
  // 发送手机验证码
  static Future sendPhoneCode(String phone, String type) async {
    return await HttpUtil.get(Api.sendPhoneCode, params: {"phone": phone, "type": type});
  }
}
