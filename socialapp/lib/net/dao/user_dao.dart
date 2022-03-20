import 'package:socialapp/net/api.dart';
import 'package:socialapp/net/http/http_util.dart';

/// 用户相关请求
class UserDao {
  // 登录
  static Future login(String username, String password, int loginType) async {
    return await HttpUtil.post(Api.userLogin, {
      "username": username,
      "password": password,
      "loginType": loginType,
    });
  }
}
