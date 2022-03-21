import 'package:flutter/material.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/widget/my_btn.dart';
import 'package:socialapp/widget/my_text.dart';

/// 聊天页
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: MyBtn(
              onPressed: () {
                Navigator.of(context).pushNamed(RouterName.welcome);
              },
              child: MyText(
                text: "To Welcome Page",
                fontSize: 50,
              )),
        ),
      ),
    );
  }
}
