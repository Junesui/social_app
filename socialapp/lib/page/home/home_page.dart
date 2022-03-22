import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/constant/home_constant.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/util/toast_util.dart';
import 'package:socialapp/widget/my_divider.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:socialapp/widget/my_text.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // TabBar控制器
  late TabController _tabController;

  /// 初始化方法
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: HomeConstant.tabBarTypes.length,
      vsync: this,
      initialIndex: HomeConstant.tabBarTypes.indexOf(HomeConstant.openType),
    );
  }

  /// 销毁方法
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            _buildAppBar(),
            // AppBar以下的内容
            _buildBody(),
          ],
        ),
      ),
      floatingActionButton: _buildPostBtn(),
    );
  }

  /// AppBar
  _buildAppBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        SU.setWidth(StyleConstant.mainLRPadding),
        StyleConstant.fromStateBar,
        SU.setWidth(StyleConstant.mainLRPadding),
        10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LOGO
          const MyText(
            text: "TODO-LOGO",
            color: StyleConstant.primaryColor,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),

          // 搜索按钮
          MyIconBtn(
            onTap: () {
              ToastUtil.show(msg: "TODO jump to search page");
            },
            icon: Feather.search,
            size: 62,
          ),
        ],
      ),
    );
  }

  /// AppBar以下的内容
  _buildBody() {
    return Expanded(
      child: Column(
        children: [
          // TabBar
          _buildTabBar(),
          MyDivider(color: Colors.grey[350]),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // children: HomeConstant.tabBarTypes.map((type) {
              //   return HomeTabView(type: type);
              // }).toList(),
              children: [
                MyText(text: "xxx"),
                MyText(text: "xxx"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// TabBar
  _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicatorColor: StyleConstant.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: HomeConstant.tabBarTypes.map((type) {
        return SizedBox(
          height: 30,
          child: Tab(
            child: MyText(
              text: type == HomeConstant.followType ? "关注" : "大厅",
              color: Colors.grey,
              fontSize: 50,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 发布按钮
  _buildPostBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouterName.post);
      },
      child: CircleAvatar(
        radius: SU.setHeight(76),
        backgroundColor: StyleConstant.primaryColor,
        child: Icon(
          FontAwesome.edit,
          color: Colors.white,
          size: SU.setFontSize(60),
        ),
      ),
    );
  }
}
