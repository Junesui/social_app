import 'package:socialapp/net/http/http_exception.dart';
import 'package:socialapp/util/toast_util.dart';

/// 接口调用完成之后的共通返回类
class ApiResponse {
  // http请求是否成功
  bool httpOK;
  // 返回的数据。{"success": true,"code": 10000,"message": "成功","data": Object}
  Map<String, dynamic>? data;
  // 返回数据是否正常成功
  bool dataOK = false;
  // 返回数据中的消息
  String dataMsg = "";
  // 异常
  HttpException? exception;

  // 成功
  ApiResponse.ok(this.data)
      : httpOK = true,
        dataOK = data!["success"] == true,
        dataMsg = (data["message"] as String);
  // 异常
  ApiResponse.error(this.exception) : httpOK = false;

  /// 请求完成后的继续处理
  static goon(ApiResponse response, Function(dynamic) cb) {
    // 如果http请求成功并且返回的数据是正常成功状态，则继续执行
    if (response.httpOK && response.dataOK) {
      cb(response.data!["data"]);
    }
    // 如果http请求成功，但是返回数据不是成功状态，提示消息
    if (response.httpOK && !response.dataOK) {
      ToastUtil.show(msg: response.dataMsg);
      return;
    }
    // 如果http请求失败，提示消息
    if (!response.httpOK) {
      String errorMsg = response.exception!.getMessage();
      if (errorMsg != "请求取消") {
        ToastUtil.show(msg: errorMsg);
      }
      return;
    }
  }
}
