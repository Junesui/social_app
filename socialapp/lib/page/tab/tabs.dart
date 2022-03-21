import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/page/tab/chat_tab_page.dart';
import 'package:socialapp/page/tab/group_tab_page.dart';
import 'package:socialapp/page/tab/home_tab_page.dart';
import 'package:socialapp/page/tab/notice_tab_page.dart';
import 'package:socialapp/page/tab/profile_tab_page.dart';
import 'package:socialapp/util/screen_util.dart';

/// Tab
class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  // 当前页index
  int _currentIndex = 0;
  // 页面控制器
  PageController _pageController = PageController(initialPage: 0);
  // 所有页面列表
  final List<Widget> _pageList = [
    HomeTabPage(),
    GroupTabPage(),
    ChatTabPage(),
    NoticeTabPage(),
    ProfileTabPage(),
  ];

  // 初始化方法
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  // 销毁方法
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageList,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// 底部导航栏
  _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.1,
            color: Colors.grey,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: StyleConstant.primaryColor,
        selectedFontSize: SU.setFontSize(26),
        unselectedFontSize: SU.setFontSize(26),
        iconSize: SU.setFontSize(60),
        elevation: 0,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        items: [
          _buildBottomItem(
            MaterialCommunityIcons.home_lightbulb_outline,
            MaterialCommunityIcons.home_lightbulb,
            "首页",
          ),
          _buildBottomItem(
            MaterialIcons.workspaces_outline,
            MaterialIcons.workspaces_filled,
            "圈子",
          ),
          _buildBottomItem(
            Ionicons.chatbubble_ellipses_outline,
            Ionicons.chatbubble_ellipses,
            "消息",
          ),
          _buildBottomItem(
            Ionicons.notifications_outline,
            Ionicons.notifications,
            "通知",
          ),
          _buildBottomItem(
            Ionicons.ios_person_outline,
            Ionicons.ios_person,
            "我的",
          ),
        ],
      ),
    );
  }

  /// 底部导航栏的item
  _buildBottomItem(IconData icon, IconData activeIcon, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Icon(icon),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Icon(activeIcon),
      ),
      label: label,
      tooltip: "",
    );
  }
}
