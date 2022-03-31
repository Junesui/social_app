import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/constant/post_constant.dart';
import 'package:socialapp/net/dao/post_dao.dart';
import 'package:socialapp/net/http/api_response.dart';
import 'package:socialapp/page/post/post_img_cell.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/util/bottom_sheet_util.dart';
import 'package:socialapp/util/perm_util.dart';
import 'package:socialapp/util/pick_util.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_appbar.dart';
import 'package:socialapp/widget/my_btn.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:socialapp/widget/my_input.dart';
import 'package:socialapp/widget/my_mask_layer.dart';
import 'package:socialapp/widget/my_text.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

/// 发布页面
class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // 输入内容控制器
  final TextEditingController _textController = TextEditingController();
  // 要上传的图片
  List<AssetEntity> _pickImgs = [];
  // 发布内容的类型。默认文本类型
  int _postType = PostConstant.textType;
  // 是否显示遮罩层
  bool _isShowMask = false;

  /// 销毁方法
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// 拍照
  _takePhoto() async {
    // 关闭底部弹窗
    Navigator.of(context).pop();
    // 隐藏键盘
    FocusScope.of(context).requestFocus(FocusNode());
    // 拍照
    PermUtil.check([Permission.camera, Permission.storage], context, onGranted: () async {
      final AssetEntity? entity = await CameraPicker.pickFromCamera(
        context,
        theme: CameraPicker.themeData(Colors.orangeAccent),
      );
      if (entity != null) {
        setState(() {
          if (_pickImgs.length >= 9) {
            _pickImgs.removeAt(0);
          }
          _pickImgs.add(entity);
        });
      }
    });
  }

  /// 从相册选择
  _pickImg() async {
    // 关闭底部弹窗
    Navigator.of(context).pop();
    // 隐藏键盘
    FocusScope.of(context).requestFocus(FocusNode());
    // 选择图片
    PermUtil.check([Permission.storage], context, onGranted: () async {
      List<AssetEntity>? entities = await PickUtil.pick(context, _pickImgs);
      if (entities.isNotEmpty) {
        setState(() {
          _pickImgs = entities;
        });
      }
    });
  }

  /// 发布
  _post() async {
    // 发布类型判断
    if (_postType == PostConstant.textType) {
      if (_pickImgs.isNotEmpty) {
        _postType = PostConstant.imageType;
      }
    }
    // 显示遮罩层
    setState(() {
      _isShowMask = true;
    });
    // 发送请求
    ApiResponse response = await PostDao.post(
      _postType,
      _textController.text,
      _pickImgs,
    );
    ApiResponse.goon(context, response, (v) {
      if (_postType == PostConstant.callType || _postType == PostConstant.videoType) {
        Navigator.of(context).pushReplacementNamed(RouterName.calling, arguments: v);
      } else {
        Navigator.of(context).pop();
      }
    });
    // 隐藏遮罩层
    setState(() {
      _isShowMask = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyMaskLayer(
      isShow: _isShowMask,
      hintText: "发布中...",
      child: Scaffold(
        appBar: MyAppBar(mTitle: "发布"),
        body: _buildBody(),
      ),
    );
  }

  /// Body
  _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SU.setWidth(StyleConstant.mainLRPadding),
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 发布内容区域
          Expanded(
            child: _buildContentArea(),
          ),
          // 语音/视频按钮
          _buildCallAndVideoBtn(),
          // 底部一行按钮
          _buildBottomRowBtn(),
        ],
      ),
    );
  }

  /// 输入内容区域
  _buildContentArea() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 文字区域
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MyInput(
              controller: _textController,
              maxLength: 200,
              fontSize: 45,
              hintText: "分享一下最近的心情吧...",
              isHasBottomLine: false,
              isCollapsed: true,
              minLines: 3,
              maxLines: 99999,
              counterStyle: TextStyle(
                color: Colors.grey,
                fontSize: SU.setFontSize(42),
              ),
            ),
          ),
          // 图片区域
          _pickImgs.isEmpty ? const SizedBox() : PostImgCell(imgs: _pickImgs),
        ],
      ),
    );
  }

  /// 通话和视频按钮
  _buildCallAndVideoBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          // 通话按钮
          GestureDetector(
            onTap: () {
              setState(() {
                if (_postType == PostConstant.callType) {
                  _postType = PostConstant.textType;
                } else {
                  _postType = PostConstant.callType;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _postType == PostConstant.callType ? Colors.green : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(0, 2))
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.call,
                    color: _postType == PostConstant.callType ? Colors.white : Colors.green,
                    size: SU.setFontSize(52),
                  ),
                  const SizedBox(width: 5),
                  MyText(
                    text: "语音",
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: _postType == PostConstant.callType ? Colors.white : Colors.green,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 2),
          // 视频按钮
          GestureDetector(
            onTap: () {
              setState(() {
                if (_postType == PostConstant.videoType) {
                  _postType = PostConstant.textType;
                } else {
                  _postType = PostConstant.videoType;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _postType == PostConstant.videoType ? Colors.teal : Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(0, 2))
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.video_call,
                    color: _postType == PostConstant.videoType ? Colors.white : Colors.teal,
                    size: SU.setFontSize(52),
                  ),
                  const SizedBox(width: 5),
                  MyText(
                    text: "视频",
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: _postType == PostConstant.videoType ? Colors.white : Colors.teal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 最底部行的按钮。选择图片，发送按钮
  _buildBottomRowBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 选择图片
        MyIconBtn(
          onTap: _buildImgSourceSelect,
          icon: Icons.image,
          size: 100,
          color: StyleConstant.primaryColor,
        ),
        // 发送按钮
        MyBtn(
          onPressed: () {
            // 判断是否可以发布
            bool _isCanPost = _textController.text.trim().isNotEmpty ||
                _pickImgs.isNotEmpty ||
                _postType == PostConstant.callType ||
                _postType == PostConstant.videoType;
            if (_isCanPost) {
              _post();
            }
          },
          child: const MyText(
            text: "发布",
            fontSize: 42,
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          color: Colors.brown,
        ),
      ],
    );
  }

  /// 拍照或从相册选择
  _buildImgSourceSelect() {
    List<BottomSheetParam> params = [];
    params.add(
      BottomSheetParam(
        text: "拍照",
        onTap: () {
          _takePhoto();
        },
      ),
    );
    params.add(
      BottomSheetParam(
        text: "从相册选择",
        onTap: () {
          _pickImg();
        },
      ),
    );
    BottomSheetUtil.show(context, params);
  }
}
