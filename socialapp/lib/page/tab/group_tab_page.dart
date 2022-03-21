import 'package:flutter/material.dart';
import 'package:socialapp/page/group/group_page.dart';

/// 组页tab
class GroupTabPage extends StatefulWidget {
  const GroupTabPage({Key? key}) : super(key: key);

  @override
  _GroupTabPageState createState() => _GroupTabPageState();
}

class _GroupTabPageState extends State<GroupTabPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GroupPage();
  }
}
