import 'package:dio/dio.dart';
import 'package:socialapp/net/http/api_response.dart';
import 'package:socialapp/net/http/http_request.dart';

class HttpUtil {
  /// 初始化
  static void init({
    required String baseUrl,
    int connectTimeout = 10000,
    int receiveTimeout = 10000,
    Map<String, String>? headers,
  }) {
    HttpRequest().init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers,
    );
  }

  /// 添加 header
  static void addHeaders(Map<String, dynamic> map) {
    HttpRequest().addHeaders(map);
  }

  /// 取消请求
  static void cancelRequests({CancelToken? token}) {
    HttpRequest().cancelRequest(token: token);
  }

  /// get 请求
  static Future get(String path, {Map<String, dynamic>? params, CancelToken? cancelToken}) async {
    try {
      dynamic respData = await HttpRequest().get(
        path,
        params: params,
        cancelToken: cancelToken,
      );
      return ApiResponse.ok(respData);
    } on DioError catch (e) {
      return ApiResponse.error(e.error);
    }
  }

  /// post 请求
  static Future post(String path, Map data, {CancelToken? cancelToken}) async {
    try {
      dynamic respData = await HttpRequest().post(
        path,
        data,
        cancelToken: cancelToken,
      );
      return ApiResponse.ok(respData).data!["data"];
    } on DioError catch (e) {
      return ApiResponse.error(e.error);
    }
  }
}
