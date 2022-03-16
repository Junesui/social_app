import 'package:flutter/material.dart';
import 'package:socialapp/constant/common_constant.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_text.dart';

/// 欢迎页
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // 背景图片
            Positioned.fill(
              child: Image.asset(
                CommonConstant.welcomeBg,
                fit: BoxFit.cover,
              ),
            ),
            // 底部登录框
            Positioned(
              bottom: 0,
              child: Container(
                width: SU.getScreenWidth(),
                height: SU.getScreenHeight() * 0.28,
                decoration: const BoxDecoration(
                  color: Color(0xcc788c82),
                  border: Border(
                    top: BorderSide(
                      width: 2,
                      color: Color(0xcc788c82),
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    _buildRegisterBtn(),
                    _buildLoginHint(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 注册按钮
  _buildRegisterBtn() {
    return Center(
      child: SizedBox(
        width: SU.setWidth(450),
        height: SU.setHeight(108),
        child: ElevatedButton(
          onPressed: () {
            print("click register button");
          },
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.teal,
              elevation: 0,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SU.setHeight(50)),
              )),
          child: const MyText(
            text: "注 册",
            color: Colors.black,
            fontSize: 48,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // 已有账号，登录提示
  _buildLoginHint() {
    return Align(
      alignment: const Alignment(0, 0.45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MyText(
            text: "已经有账号了？",
            fontSize: 36,
          ),
          InkWell(
            onTap: () {
              print("click login font");
            },
            child: const MyText(
              text: "登录",
              fontSize: 36,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
