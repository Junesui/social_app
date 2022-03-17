import 'package:flutter/material.dart';
import 'package:socialapp/constant/common_constant.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/util/toast_util.dart';
import 'package:socialapp/widget/my_text.dart';

/// 欢迎页
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // 是否同意协议
  bool _isAgree = false;

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
            // 登录/注册，同意协议区域
            Positioned(
              bottom: 0,
              child: Container(
                width: SU.getScreenWidth(),
                height: SU.getScreenHeight() * 0.23,
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
                    // 登录/注册按钮
                    _buildLoginRegisterBtn(),
                    // 同意协议
                    _buildAgreement(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 登录/注册按钮
  _buildLoginRegisterBtn() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_isAgree) {
            Navigator.of(context).pushNamed(RouterName.login);
          } else {
            ToastUtil.show(msg: "请先勾选同意按钮");
          }
        },
        style: ElevatedButton.styleFrom(
            onPrimary: CommonConstant.primaryColor,
            elevation: 10,
            primary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: SU.setWidth(120)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SU.setHeight(50)),
            )),
        child: const MyText(
          text: "登录/注册",
          color: Colors.black,
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 同意协议
  _buildAgreement() {
    return Align(
      alignment: const Alignment(0, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CheckBox 图标
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Transform.scale(
              scale: 0.7,
              child: SizedBox(
                width: SU.setWidth(60),
                child: Checkbox(
                  value: _isAgree,
                  onChanged: (isAgree) {
                    setState(() {
                      _isAgree = isAgree ?? false;
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: Colors.black45,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const CircleBorder(side: BorderSide(color: Colors.white)),
                ),
              ),
            ),
          ),
          // 文字
          Row(
            children: [
              const MyText(
                text: "我已阅读并同意",
                color: Colors.white,
                fontSize: 36,
              ),
              GestureDetector(
                onTap: () {
                  ToastUtil.show(msg: "跳转隐私政策页面");
                },
                child: const MyText(
                  text: "隐私政策",
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
              const MyText(
                text: "和",
                color: Colors.white,
                fontSize: 36,
              ),
              GestureDetector(
                onTap: () {
                  ToastUtil.show(msg: "跳转用户协议页面");
                },
                child: const MyText(
                  text: "用户协议",
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
