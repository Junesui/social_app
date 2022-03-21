import 'package:flutter/material.dart';
import 'package:socialapp/widget/my_text.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: MyText(text: "HomePage"),
        ),
      ),
    );
  }
}
