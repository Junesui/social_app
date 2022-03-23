import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:socialapp/net/http/http_exception.dart';
import 'package:socialapp/util/log_util.dart';

/// 错误拦截器
class MyErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // 网络连接
    await _handleNetWorkError(err);

    // 错误统一处理
    HttpException appException = HttpException.create(err);

    // TODO 错误日志上传
    LogUtil.p("错误日志上传: ${err.error} - ${err.requestOptions.uri}");

    err.error = appException;
    return super.onError(err, handler);
  }

  /// 处理网络连接
  _handleNetWorkError(DioError err) async {
    // 网络连接错误
    if (err.error is SocketException) {
      err.error = MyDioSocketException(
        err.message,
        osError: err.error?.osError,
        address: err.error?.address,
        port: err.error?.port,
      );
    }
    // 如果没有连接网络，修改错误消息
    if (err.type == DioErrorType.other) {
      bool isConnectNetWork = await isConnected();
      if (err.error is MyDioSocketException && !isConnectNetWork) {
        err.error.message = "网络连接不可用，请检查网络";
      }
    }
  }

  /// 是否有网络连接
  Future<bool> isConnected() async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}

/// 自定义一个 socket 类，因为 SocketException 的 message 是只读
class MyDioSocketException implements SocketException {
  @override
  String message;

  @override
  final InternetAddress? address;

  @override
  final OSError? osError;

  @override
  final int? port;

  MyDioSocketException(
    this.message, {
    this.osError,
    this.address,
    this.port,
  });
}
