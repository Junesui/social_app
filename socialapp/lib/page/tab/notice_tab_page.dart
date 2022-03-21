import 'package:flutter/material.dart';
import 'package:socialapp/page/notice/notice_page.dart';

/// 消息通知页tab
class NoticeTabPage extends StatefulWidget {
  const NoticeTabPage({Key? key}) : super(key: key);

  @override
  _NoticeTabPageState createState() => _NoticeTabPageState();
}

class _NoticeTabPageState extends State<NoticeTabPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NoticePage();
  }
}
