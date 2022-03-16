import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socialapp/net/api.dart';
import 'package:socialapp/net/http/http_util.dart';
import 'package:socialapp/router/router.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_text.dart';

void main() {
  // 初始化
  _init();

  runApp(const MyApp());

  // // 设置状态栏背景为透明
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // // 设置状态栏文字为白色
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
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
          initialRoute: RouterName.welcome,
          onGenerateRoute: onGenerateRoute,

          // 主题
          theme: ThemeData(
              // 取消一些组件的默认点击效果
              // highlightColor: Colors.transparent,
              // splashColor: Colors.transparent,
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

/// 全局初始化
_init() {
  // 网络请求初始化
  HttpUtil.init(baseUrl: Api.baseUrl);
}
