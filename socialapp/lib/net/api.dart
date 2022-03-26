/// 请求 API
class Api {
  // TODO 修改为正确的根路径
  /// API 根路径
  static const baseUrl = "http://192.168.3.25/dev";

  /// 共通
  // 发送手机验证码
  static const sendPhoneCode = "$baseUrl/phonecode/send";

  /// 用户相关
  // 登录
  static const login = "$baseUrl/user/login";

  /// 发布相关
  // 发布
  static const post = "$baseUrl/post/post";
}
