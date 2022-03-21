import 'package:flutter/material.dart';
import 'package:socialapp/widget/my_text.dart';

/// 消息通知页
class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: MyText(text: "NoticePage"),
        ),
      ),
    );
  }
}
