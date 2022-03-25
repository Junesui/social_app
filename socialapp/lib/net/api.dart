/// 请求 API
class Api {
  // TODO 修改为正确的根路径
  // API 根路径
  static const baseUrl = "http://192.168.3.25/dev";

  /// 共通
  // 发送手机验证码
  static const sendPhoneCode = "$baseUrl/phonecode/send";

  /// 用户相关
  static const userLogin = "$baseUrl/user/login";
}
