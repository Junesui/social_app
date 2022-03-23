import 'package:dio/dio.dart';
import 'package:socialapp/util/log_util.dart';

class MyLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtil.p("\n================== 请求数据 ==========================");
    LogUtil.p("请求url：${options.path}");
    LogUtil.p('请求头: ' + options.headers.toString());
    LogUtil.p('请求参数: ' + options.queryParameters.toString());
    LogUtil.p('请求方法: ' + options.method);
    LogUtil.p("contentType = ${options.contentType}");
    LogUtil.p('请求时间: ' + DateTime.now().toString());
    if (options.data != null) {
      LogUtil.p('请求数据: ' + options.data.toString());
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtil.p("\n================== 响应数据 ==========================");
    LogUtil.p("url = ${response.realUri.path}");
    LogUtil.p("code = ${response.statusCode}");
    LogUtil.p("data = ${response.data}");
    LogUtil.p('返回时间: ' + DateTime.now().toString());
    LogUtil.p("\n");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError e, ErrorInterceptorHandler handler) {
    LogUtil.p("\n================== 错误响应数据 ======================");
    LogUtil.p("type = ${e.type}");
    LogUtil.p("message = ${e.message}");
    LogUtil.p('response = ${e.response}');
    LogUtil.p("\n");
    return super.onError(e, handler);
  }
}
