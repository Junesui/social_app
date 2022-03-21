import 'package:flutter/material.dart';
import 'package:socialapp/widget/my_text.dart';

/// 个人信息页
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: MyText(text: "ProfilePage"),
        ),
      ),
    );
  }
}
