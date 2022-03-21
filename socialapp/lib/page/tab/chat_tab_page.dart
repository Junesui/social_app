import 'package:flutter/material.dart';
import 'package:socialapp/page/chat/chat_page.dart';

/// 聊天页tab
class ChatTabPage extends StatefulWidget {
  const ChatTabPage({Key? key}) : super(key: key);

  @override
  _ChatTabPageState createState() => _ChatTabPageState();
}

class _ChatTabPageState extends State<ChatTabPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChatPage();
  }
}
