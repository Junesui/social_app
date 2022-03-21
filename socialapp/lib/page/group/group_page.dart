import 'package:flutter/material.dart';
import 'package:socialapp/widget/my_text.dart';

/// 组页
class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: MyText(text: "GroupPage"),
        ),
      ),
    );
  }
}
