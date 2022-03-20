import 'package:dio/dio.dart';

/// 请求拦截器
class MyRequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.copyWith(
    // );

    // 添加请求头
    // options.headers.addAll();
    // print(options.uri.toString());
    return super.onRequest(options, handler);
  }
}
