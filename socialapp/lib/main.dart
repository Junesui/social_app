import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socialapp/constant/common/sk_constant.dart';
import 'package:socialapp/net/http/http_util.dart';
import 'package:socialapp/router/router.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/util/sp_util.dart';
import 'package:socialapp/widget/my_text.dart';

String _initialRoute = RouterName.welcome;
void main() async {
  // 确保拥有 WidgetsBinding (解决异步初始化导致报错)
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化
  await _init();

  runApp(const MyApp());

  // 设置状态栏背景为透明
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // 设置状态栏文字为黑色
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

/// 全局初始化
_init() async {
  // 初始化路由
  _initialRoute = await _getInitRoute();

  // 网络请求初始化
  // 开发模式下为了方便调试设置超时时间
  if (kDebugMode) {
    HttpUtil.init(
      connectTimeout: 10 * 10000,
      receiveTimeout: 10 * 10000,
    );
  } else {
    HttpUtil.init();
  }
}

/// 获取初始化路由
Future<String> _getInitRoute() async {
  bool isAgree = await SpUtil.getBool(SKConstant.welcomeIsAgree) ?? false;
  // 如果没有同意协议，跳转到欢迎页
  if (!isAgree) {
    return RouterName.welcome;
  } else {
    // 否则跳转到首页
    return RouterName.root;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      builder: () => _buildPullToRefreshConf(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: _initialRoute,
          onGenerateRoute: onGenerateRoute,

          // 主题
          theme: ThemeData(
            // 为了使AppBar文字颜色自适应，primarySwatch设置一个颜色
            primarySwatch: Colors.yellow,
            // 日间模式
            brightness: Brightness.light,
            // 点击高亮颜色设为透明
            highlightColor: Colors.transparent,
            // 溅墨颜色设为透明
            splashColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  /// 下拉刷新-上拉加载 全局配置
  _buildPullToRefreshConf(Widget child) {
    return RefreshConfiguration(
      headerBuilder: () => WaterDropHeader(
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white60,
              size: SU.setFontSize(45),
            ),
            const SizedBox(width: 5),
            const MyText(
              text: "刷新成功",
              fontSize: 40,
            ),
          ],
        ),
        failed: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.white60,
              size: SU.setFontSize(45),
            ),
            const SizedBox(width: 5),
            const MyText(
              text: "刷新失败",
              fontSize: 40,
            ),
          ],
        ),
      ),
      footerBuilder: () => CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const MyText(text: "");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const MyText(text: "加载失败！点击重试！");
          } else if (mode == LoadStatus.canLoading) {
            body = const MyText(text: "");
          } else {
            body = const MyText(text: "没有更多数据了!");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      headerTriggerDistance: 80.0,
      maxOverScrollExtent: 120,
      maxUnderScrollExtent: 0,
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: true,
      hideFooterWhenNotFull: true,
      enableBallisticLoad: true,
      child: child,
    );
  }
}
