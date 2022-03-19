/// 格式验证工具类
class FormatValidUtil {
  // 手机号码验证
  static bool isChinaPhone(String str) {
    return RegExp('^1(3|4|5|6|7|8|9)\\d{9}\$').hasMatch(str);
  }
}
