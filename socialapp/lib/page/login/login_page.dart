import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:socialapp/constant/common/sk_constant.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/constant/phone_code_constant.dart';
import 'package:socialapp/constant/user_constant.dart';
import 'package:socialapp/net/dao/common_dao.dart';
import 'package:socialapp/net/dao/user_dao.dart';
import 'package:socialapp/net/http/api_response.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/util/format_valid_util.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/util/storage_util.dart';
import 'package:socialapp/util/toast_util.dart';
import 'package:socialapp/widget/my_btn.dart';
import 'package:socialapp/widget/my_divider.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:socialapp/widget/my_input.dart';
import 'package:socialapp/widget/my_mask_layer.dart';
import 'package:socialapp/widget/my_text.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 手机号输入框控制器
  final TextEditingController _phoneController = TextEditingController();
  // 验证码输入框控制器
  final TextEditingController _codeController = TextEditingController();
  // 用户名输入框控制器
  final TextEditingController _usernameController = TextEditingController();
  // 密码输入框控制器
  final TextEditingController _passwordController = TextEditingController();
  // 验证码输入框焦点
  final FocusNode _codeFocusNode = FocusNode();
  // 是否显示遮罩层
  bool _isShowMask = false;
  // 遮罩层提示文字
  String? _maskHintText;
  // 是否使用手机验证码登录
  bool _isCodeLogin = true;
  // 是否显示手机验证码输入框
  bool _isShowCodeInput = false;
  // 是否已发送验证码
  bool _isSendCode = false;
  // 倒计时秒数
  int _second = 60;

  /// 销毁方法
  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  /// 发送手机验证码
  _sendCode(String phone) async {
    // 验证手机号格式
    bool success = FormatValidUtil.isChinaPhone(phone);
    if (!success) {
      ToastUtil.show(msg: "手机号码格式不正确");
      return;
    }
    // 手机号格式正确，显示遮罩层
    setState(() {
      _isShowMask = true;
      _maskHintText = "发送验证码";
    });
    // 发送验证码
    ApiResponse response = await CommonDao.sendPhoneCode(phone, PhoneCodeConstant.codeTypeLogin);
    ApiResponse.goon(response, (data) {
      setState(() {
        _isShowCodeInput = true;
        _isSendCode = true;
        _codeFocusNode.requestFocus();
        _codeController.text = "";
        _second = 60;
        Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _second -= 1;
          });
          if (_second <= 0) {
            setState(() {
              _isSendCode = false;
            });
            timer.cancel();
          }
        });
      });
    });
    // 隐藏遮罩层
    setState(() {
      _isShowMask = false;
    });
  }

  /// 登录
  _login(String username, String password, int loginType) async {
    // 如果是手机验证码登录，验证验证码基本格式
    if (loginType == UserConstant.loginTypePhoneCode && password.length != 6) {
      ToastUtil.show(msg: "验证码错误");
      return;
    }
    // 基本格式验证通过，显示遮罩层
    setState(() {
      _isShowMask = true;
      _maskHintText = "登录中...";
    });
    // 发送登录请求
    ApiResponse response = await UserDao.login(username, password, loginType);
    ApiResponse.goon(response, (token) async {
      setState(() {
        _isShowMask = false;
      });
      // 保存token，跳转到首页
      await StorageUtil.setString(SKConstant.loginToken, token);
      Navigator.of(context).pushNamed(RouterName.root);
    });
    // 隐藏遮罩层
    setState(() {
      _isShowMask = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 解决键盘弹起撑起内容导致布局溢出问题
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: MyMaskLayer(
          child: _buildBody(),
          isShow: _isShowMask,
          hintText: _maskHintText,
        ),
      ),
    );
  }

  /// 主内容
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
          // 关闭按钮和登录区域
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 关闭按钮
              MyIconBtn(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.close,
                size: 90,
              ),
              // 登录区域
              _isCodeLogin ? _buildCodeLogin() : _buildAccountLogin(),
            ],
          ),

          // 第三方登录区域
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
          // 标题
          const MyText(
            text: "账号密码登录",
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: SU.setHeight(80)),
          // 用户名
          MyInput(
            hintText: "手机号",
            fontSize: 46,
            controller: _usernameController,
          ),
          // 密码
          MyInput(
            hintText: "密码",
            fontSize: 46,
            controller: _passwordController,
            isObscure: true,
          ),
          SizedBox(height: SU.setHeight(80)),
          // 登录按钮
          MyBtn(
            onPressed: () {
              _login(
                _usernameController.text.trim(),
                _passwordController.text.trim(),
                UserConstant.loginTypeAccount,
              );
            },
            child: const MyText(
              text: "登录",
              fontSize: 52,
              color: Colors.white,
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
                _isCodeLogin = true;
              });
            },
            rightText: "忘记密码?",
            rightOnTap: () {
              ToastUtil.show(msg: "TODO 忘记密码");
            },
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
          // 标题
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
          MyInput(
            hintText: "请输入手机号",
            fontSize: 46,
            controller: _phoneController,
            keyboardType: TextInputType.number,
            onChanged: (v) {
              setState(() {
                _isShowCodeInput = false;
              });
            },
          ),
          // 验证码
          _isShowCodeInput ? _buildCodeInput() : const SizedBox(),
          const MyDivider(),
          SizedBox(height: SU.setHeight(80)),
          // 按钮
          MyBtn(
            onPressed: () {
              if (!_isShowCodeInput) {
                // 发送验证码
                _sendCode(_phoneController.text.trim());
              } else {
                // 登录
                _login(
                  _phoneController.text.trim(),
                  _codeController.text.trim(),
                  UserConstant.loginTypePhoneCode,
                );
              }
            },
            child: MyText(
              text: _isShowCodeInput ? "登录" : "获取验证码",
              fontSize: 52,
              color: Colors.white,
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          SizedBox(height: SU.setHeight(30)),
          // 账号密码登录，收不到短信文字
          _buildLoginSwitch(
            leftText: "账号密码登录",
            leftOnTap: () {
              setState(() {
                _isCodeLogin = false;
              });
            },
            rightText: "收不到短信?",
            rightOnTap: () {
              ToastUtil.show(msg: "TODO 收不到短信");
            },
          ),
        ],
      ),
    );
  }

  /// 验证码输入框
  _buildCodeInput() {
    return Row(
      children: [
        // 输入验证码区域
        Expanded(
          child: MyInput(
            hintText: "请输入验证码",
            fontSize: 46,
            controller: _codeController,
            focusNode: _codeFocusNode,
          ),
        ),
        // 获取验证码按钮
        GestureDetector(
          onTap: () {
            if (!_isSendCode) {
              _sendCode(_phoneController.text.trim());
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: MyText(
              text: _isSendCode ? "重新获取($_second)" : "获取验证码",
              fontSize: 36,
              color: _isSendCode ? Colors.grey : null,
            ),
          ),
        ),
      ],
    );
  }

  /// 第三方登录
  _buildThirdLogin() {
    return Column(
      children: [
        // 第三方登录文字
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: MyDivider(
                color: Colors.grey[300],
                indent: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MyText(
                text: "第三方登录",
                fontSize: 32,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: MyDivider(
                color: Colors.grey[300],
                endIndent: 20,
              ),
            ),
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
    return GestureDetector(
      onTap: () {
        ToastUtil.show(msg: "TODO 跳转第三方APP登录");
      },
      child: CircleAvatar(
        radius: SU.setHeight(50),
        backgroundColor: backgroundColor,
        child: Icon(
          icon,
          color: Colors.white,
          size: SU.setFontSize(50),
        ),
      ),
    );
  }
}
