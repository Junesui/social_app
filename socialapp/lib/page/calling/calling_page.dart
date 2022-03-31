import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/constant/common/asset_constant.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/model/calling/calling_room_info_model.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/third/Zego.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_avatar.dart';
import 'package:socialapp/widget/my_countup.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:socialapp/widget/my_text.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

// 分隔符
String _split = "#_#";

/// 通话页面
class CallingPage extends StatefulWidget {
  // CallingRoomInfoModal
  final Map arguments;

  const CallingPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _CallingPageState createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  // 输入框焦点节点
  final FocusNode _inputFocusNode = FocusNode();
  //输入框控制器
  final TextEditingController _editingController = TextEditingController();
  // 输入框后面的图标是否是拷贝
  bool _isCopy = true;
  // 房主等待用户加入状态
  bool _isOwnerWaiting = true;
  // 是否隐藏表情
  bool _isHideEmoji = true;

  // 房间用户【用户ID${_split}用户头像${_split}用户昵称】
  List<String> _loginUserIds = [];

  @override
  void initState() {
    super.initState();
    // 初始化Zego
    _initZego();
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    _editingController.dispose();
    // 暂时销毁，实际点击退出才销毁
    Zego.destroyEngine();
    super.dispose();
  }

  /// 初始化Zego
  _initZego() {
    CallingRoomInfoModel model = CallingRoomInfoModel.fromJson(widget.arguments);
    int _appId = model.appId ?? 0;
    String _roomId = model.roomId.toString();
    String _userId = model.userId.toString();
    String _token = model.token ?? "";
    String _ownerAvatar = model.avatarThum ?? "";
    String _ownerNickname = model.nickname ?? "";
    String _loginUserId = _userId + _split + _ownerAvatar + _split + _ownerNickname;
    _loginUserIds.add(_loginUserId);

    // 创建引擎，登陆房间
    Zego.createEngine(_appId);
    ZegoRoomConfig config = ZegoRoomConfig.defaultConfig();
    config.isUserStatusNotify = true;
    config.token = _token;
    // Zego.loginRoom(userId, roomId, config);
    Zego.loginRoom(_loginUserId, "46", config);

    // 监听用户状态更新
    ZegoExpressEngine.onRoomUserUpdate = (
      String roomID,
      ZegoUpdateType updateType,
      List<ZegoUser> userList,
    ) {
      setState(() {
        _isOwnerWaiting = false;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff212121),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(SU.setWidth(StyleConstant.mainLRPadding)),
          child: Column(
            children: [
              _buildAppBar(),
              const SizedBox(height: 6),
              _buildInput(),
              Expanded(child: _isOwnerWaiting ? _buildOwnerWaitingAvatar() : _buildAvatars()),
              _buildTextAndEmojis(),
              const SizedBox(height: 6),
              _buildSmallPlayIcon(),
              const SizedBox(height: 6),
              _buildBigFunctionIcon(),
            ],
          ),
        ),
      ),
    );
  }

  /// AppBar
  _buildAppBar() {
    return Row(
      children: [
        // 图标
        Icon(
          Icons.group,
          color: Colors.white70,
          size: SU.setFontSize(70),
        ),
        const SizedBox(width: 15),
        // 通话时长
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MyText(
              text: "通話中",
              fontSize: 40,
              color: Colors.white70,
            ),
            MyCountup(),
          ],
        ),
        const Spacer(),
        // 邀请按钮
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(RouterName.callingInvite);
          },
          child: Chip(
            backgroundColor: Colors.grey[800],
            labelPadding: const EdgeInsets.symmetric(horizontal: 5),
            label: Row(
              children: [
                Icon(
                  Icons.person_add_alt,
                  color: Colors.white70,
                  size: SU.setFontSize(52),
                ),
                const SizedBox(width: 3),
                const MyText(
                  text: "邀请",
                  fontSize: 35,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 3),
        // 最小化按钮
        GestureDetector(
          onTap: () {},
          child: Chip(
            backgroundColor: Colors.grey[800],
            shape: const CircleBorder(),
            label: Icon(
              Icons.expand_more,
              color: Colors.white70,
              size: SU.setFontSize(65),
            ),
          ),
        ),
      ],
    );
  }

  /// 输入框
  _buildInput() {
    OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(SU.setHeight(80)),
      borderSide: BorderSide.none,
    );

    return TextFormField(
      controller: _editingController,
      cursorColor: StyleConstant.primaryColor,
      textAlignVertical: TextAlignVertical.center,
      maxLines: 2,
      minLines: 1,
      style: TextStyle(
        color: Colors.white,
        fontSize: SU.setFontSize(36),
      ),
      focusNode: _inputFocusNode,
      decoration: InputDecoration(
        hintText: "分享游戏ID或游戏房间密码等...",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: SU.setFontSize(36),
        ),
        filled: true,
        fillColor: Colors.black54,
        focusedBorder: _outlineInputBorder,
        isCollapsed: true,
        contentPadding: EdgeInsets.fromLTRB(
          SU.setWidth(60),
          SU.setHeight(36),
          SU.setWidth(10),
          SU.setHeight(36),
        ),
        border: _outlineInputBorder,
        suffixIcon: GestureDetector(
          onTap: () {
            String text = _editingController.value.text;
            if (_isCopy && text.isNotEmpty) {
              Clipboard.setData(ClipboardData(text: text));
            } else {
              print("--> 更新数据");
              setState(() {
                _isCopy = true;
                _inputFocusNode.unfocus();
                text = text + "";
              });
            }
          },
          child: Icon(
            _isCopy ? Icons.copy : Icons.refresh,
            color: Colors.white70,
            size: SU.setFontSize(62),
          ),
        ),
        suffix: const MyText(
          text: "・by suiz",
          fontSize: 32,
          color: Colors.grey,
        ),
      ),
    );
  }

  /// 中间部分：房主等待状态的头像
  _buildOwnerWaitingAvatar() {
    String _ownerAvatar = _loginUserIds[0].split(_split)[1];
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(AssetConstant.waitingRipple),
        SizedBox(
          height: SU.setHeight(300),
          width: SU.setHeight(300),
          child: Center(
            child: Stack(
              children: [
                // 头像
                MyAvatar(
                  userId: 1,
                  avatarUrl: _ownerAvatar,
                  radius: 130,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 中间部分：用户头像
  _buildAvatars() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 4 / 5,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: _loginUserIds.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 头像
              MyAvatar(
                userId: 1,
                avatarUrl: _loginUserIds[index].split(_split)[1],
                radius: 90,
              ),
              const SizedBox(height: 5),
              // 昵称
              Center(
                child: MyText(
                  text: "昵称$index",
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 等待用户加入，和表情
  _buildTextAndEmojis() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 文字
        const MyText(
          text: "等待其他参与者加入...",
          fontSize: 50,
          color: Colors.white,
        ),
        // 表情
        Offstage(
          offstage: _isHideEmoji,
          child: _buildEmojis(),
        ),
      ],
    );
  }

  /// 四个小按钮 【游戏，表情，说话，设置】
  _buildSmallPlayIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 游戏
        _buildSmallPlayIconItem(Icons.sports_esports, () {
          Navigator.of(context).pushNamed(RouterName.game);
        }),
        // 表情
        _buildSmallPlayIconItem(Icons.tag_faces, () {
          setState(() {
            _isHideEmoji = !_isHideEmoji;
          });
        }),
        // 说话
        _buildSmallPlayIconItem(Icons.record_voice_over, () {}),
        //设置
        _buildSmallPlayIconItem(Icons.settings, () {
          Navigator.of(context).pushNamed(RouterName.callingSettings);
        }),
      ],
    );
  }

  /// 小按钮子项
  _buildSmallPlayIconItem(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        backgroundColor: Colors.grey[800],
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(5),
        label: Icon(
          icon,
          size: SU.setFontSize(62),
          color: Colors.white70,
        ),
      ),
    );
  }

  /// 最底部四个大按钮 【音乐，扩声器，麦克风，退出】
  _buildBigFunctionIcon() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SU.setHeight(36)),
        color: Colors.grey[800],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBigFuncionIconItem(Icons.music_note, Colors.white70, "BGM", true, () {}),
          _buildVerticalDiveder(),
          _buildBigFuncionIconItem(Icons.volume_up, Colors.white70, "扬声器", true, () {}),
          _buildVerticalDiveder(),
          _buildBigFuncionIconItem(Icons.mic, Colors.white70, "麦克风", true, () {}),
          _buildVerticalDiveder(),
          _buildBigFuncionIconItem(Icons.logout, Colors.red, "退出", false, () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }

  /// 最底部四个大按钮子项
  _buildBigFuncionIconItem(
    IconData icon,
    Color color,
    String text,
    bool isHasRightLine,
    VoidCallback onTap,
  ) {
    return Row(
      children: [
        Column(
          children: [
            MyIconBtn(
              onTap: onTap,
              icon: icon,
              size: 70,
              color: color,
            ),
            const SizedBox(height: 3),
            MyText(
              text: text,
              color: color,
              fontSize: 30,
            ),
          ],
        ),
      ],
    );
  }

  /// 垂直分割线
  _buildVerticalDiveder() {
    return SizedBox(
      height: SU.setHeight(100),
      child: const VerticalDivider(
        color: Colors.white12,
      ),
    );
  }

  /// 表情
  _buildEmojis() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        MyText(text: Emojis.fire, fontSize: 60),
        MyText(text: Emojis.redHeart, fontSize: 60),
        MyText(text: Emojis.pileOfPoo, fontSize: 60),
        MyText(text: Emojis.wavingHand, fontSize: 60),
        MyText(text: Emojis.clappingHands, fontSize: 60),
        MyText(text: Emojis.faceWithTearsOfJoy, fontSize: 60),
        MyText(text: Emojis.loudlyCryingFace, fontSize: 60),
      ],
    );
  }
}
