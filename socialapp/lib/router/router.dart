import 'package:flutter/cupertino.dart';
import 'package:socialapp/page/common/photo_view_page.dart';
import 'package:socialapp/page/login/login_page.dart';
import 'package:socialapp/page/welcome/welcome_page.dart';
import 'package:socialapp/router/router_name.dart';

//配置路由
final Map<String, Function> routes = {
  RouterName.photoView: (context, {arguments}) => PhotoViewPage(arguments: arguments),
  RouterName.welcome: (context) => WelcomePage(),
  RouterName.login: (context) => LoginPage(),
};

//固定写法 [CupertinoPageRoute: ios风格的路由]
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(
          builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = CupertinoPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
