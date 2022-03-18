import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/util/toast_util.dart';
import 'package:socialapp/widget/my_btn.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:socialapp/widget/my_mask_layer.dart';
import 'package:socialapp/widget/my_text.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 用户名输入框控制器
  final TextEditingController _usernameController = TextEditingController();
  // 密码输入框控制器
  final TextEditingController _passwordController = TextEditingController();
  // 手机号输入框控制器
  final TextEditingController _phoneController = TextEditingController();
  // 验证码输入框控制器
  final TextEditingController _codeController = TextEditingController();
  // 是否展示遮罩层
  bool _isShowMask = false;
  // 是否使用账号密码登录
  bool _isAccountLogin = false;
  // 是否已获取手机验证码
  bool _isGetCode = false;

  // 销毁方法
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: MyMaskLayer(
          isShow: _isShowMask,
          child: _buildBody(),
          hintText: "登录中...",
        ),
      ),
    );
  }

  /// Body
  _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SU.setWidth(StyleConstant.mainLRPadding),
        vertical: SU.setHeight(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 关闭按钮
              MyIconBtn(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.close,
                color: Colors.black54,
                size: 90,
              ),
              // 登录区域
              _isAccountLogin ? _buildAccountLogin() : _buildCodeLogin(),
            ],
          ),
          // 第三方登录
          _buildThirdLogin(),
        ],
      ),
    );
  }

  /// 账号密码登录
  _buildAccountLogin() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SU.setWidth(80),
        vertical: SU.setHeight(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 账号密码登录标题
          const MyText(
            text: "账号密码登录",
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: SU.setHeight(80)),
          // 用户名
          _buildInput("手机号", false, _usernameController),
          _buildDivider(),
          // 密码
          _buildInput("密码", true, _passwordController),
          _buildDivider(),
          SizedBox(height: SU.setHeight(80)),
          // 登录按钮
          MyBtn(
            onPressed: () {
              setState(() {
                _isShowMask = true;
                // TODO 登录
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    _isShowMask = false;
                  });
                });
              });
            },
            child: const MyText(
              text: "登录",
              fontSize: 52,
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          SizedBox(height: SU.setHeight(30)),
          // 手机验证码登录，忘记密码
          _buildLoginSwitch(
            leftText: "手机验证码登录",
            leftOnTap: () {
              setState(() {
                _isAccountLogin = false;
              });
            },
            rightText: "忘记密码?",
            rightOnTap: () {},
          ),
        ],
      ),
    );
  }

  /// 手机验证码登录
  _buildCodeLogin() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SU.setWidth(80),
        vertical: SU.setHeight(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 手机验证码登录标题
          const MyText(
            text: "手机验证码登录",
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),
          const MyText(
            text: "未注册手机号验证通过后将自动注册",
            fontSize: 32,
            color: Colors.grey,
          ),
          SizedBox(height: SU.setHeight(80)),
          // 手机号
          _buildInput("请输入手机号", false, _phoneController),
          _buildDivider(),
          // 验证码
          _isGetCode ? _buildCodeInput() : const SizedBox(),
          _buildDivider(),
          SizedBox(height: SU.setHeight(80)),
          // 登录按钮
          MyBtn(
            onPressed: () {
              // TODO 发送手机验证码
              setState(() {
                _isGetCode = true;
                // _isShowMask = true;
                // Future.delayed(Duration(seconds: 2), () {
                //   setState(() {
                //     _isShowMask = false;
                //   });
                // });
              });
            },
            child: MyText(
              text: _isGetCode ? "登录" : "获取验证码",
              fontSize: 52,
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          SizedBox(height: SU.setHeight(30)),
          // 账号密码登录，收不到短信
          _buildLoginSwitch(
            leftText: "账号密码登录",
            leftOnTap: () {
              setState(() {
                _isAccountLogin = true;
              });
            },
            rightText: "收不到短信?",
            rightOnTap: () {},
          ),
        ],
      ),
    );
  }

  /// 第三方登录
  _buildThirdLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 第三方登录文字
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _buildDivider()),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MyText(
                text: "第三方登录",
                fontSize: 32,
                color: Colors.grey,
              ),
            ),
            Expanded(child: _buildDivider()),
          ],
        ),
        // 第三方APP图标
        Padding(
          padding: EdgeInsets.symmetric(vertical: SU.setHeight(80)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildThirdAppIcon(FontAwesome.qq, Colors.blue),
              _buildThirdAppIcon(FontAwesome.wechat, Colors.green),
              _buildThirdAppIcon(FontAwesome.weibo, Colors.lightBlueAccent),
            ],
          ),
        ),
      ],
    );
  }

  // 输入框
  _buildInput(String hintText, bool isPassword, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      cursorWidth: 2,
      cursorColor: StyleConstant.primaryColor,
      cursorRadius: const Radius.circular(10),
      style: TextStyle(
        color: Colors.black,
        fontSize: SU.setFontSize(46),
      ),
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: SU.setFontSize(46),
        ),
      ),
    );
  }

  // 验证码输入框
  _buildCodeInput() {
    return Row(
      children: [
        Expanded(child: _buildInput("请输入验证码", false, _codeController)),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const MyText(
            text: "获取验证码",
            fontSize: 36,
          ),
        ),
      ],
    );
  }

  // 输入框下面的分割线
  _buildDivider() {
    return Divider(color: Colors.grey[400], height: 0);
  }

  // 切换登录方式和忘记密码文字
  _buildLoginSwitch({
    required String leftText,
    VoidCallback? leftOnTap,
    required String rightText,
    VoidCallback? rightOnTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: leftOnTap,
          child: MyText(
            text: leftText,
            fontSize: 38,
            color: Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: rightOnTap,
          child: MyText(
            text: rightText,
            fontSize: 38,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // 第三方app图标子项
  _buildThirdAppIcon(IconData icon, Color backgroundColor) {
    return CircleAvatar(
      radius: SU.setHeight(50),
      backgroundColor: backgroundColor,
      child: MyIconBtn(
        onTap: () {
          ToastUtil.show(msg: "TODO 跳转第三方APP登录");
        },
        icon: icon,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
