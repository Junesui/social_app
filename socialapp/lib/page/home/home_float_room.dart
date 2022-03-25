import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/model/home/home_calling_model.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_avatar.dart';
import 'package:socialapp/widget/my_btn.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:socialapp/widget/my_text.dart';

/// 首页点击通话房间，弹出悬浮的通话房间弹窗
class HomeFloatRoom extends StatefulWidget {
  final List<Posts> posts;
  final int index;

  const HomeFloatRoom({Key? key, required this.posts, required this.index}) : super(key: key);

  @override
  _HomeFloatRoomState createState() => _HomeFloatRoomState();
}

class _HomeFloatRoomState extends State<HomeFloatRoom> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: widget.posts.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildRoom(widget.posts[index]);
      },
      index: widget.index,
      loop: false,
      viewportFraction: 0.8,
      scale: 0.8,
    );
  }

  /// 通话房间弹窗子项
  _buildRoom(Posts post) {
    return Column(
      children: [
        // 空白占位，点击关闭当前页
        _buildBlankPlaceHolder(),
        // 弹窗内容
        Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SU.setHeight(60))),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 更多按钮
                  Align(
                    alignment: Alignment.centerRight,
                    child: MyIconBtn(
                      onTap: () {
                        _buildMoreBottomSheet();
                      },
                      icon: Icons.more_horiz,
                      size: 70,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 3),
                  // 标题
                  MyText(
                    text: (post.text?.isEmpty ?? true) ? "默认标题" : post.text!,
                    fontSize: 40,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  // 头像
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: post.conferenceCall!.conferenceCallUsers!.map((callUser) {
                      return Stack(
                        children: [
                          // 头像
                          MyAvatar(
                            userId: callUser.id!,
                            avatarUrl: callUser.profileIconThumbnail,
                            radius: 50,
                          ),
                          // 房主图标
                          post.user?.id != callUser.id
                              ? const SizedBox()
                              : Container(
                                  height: SU.setHeight(36),
                                  width: SU.setWidth(36),
                                  decoration: BoxDecoration(
                                    color: StyleConstant.primaryColor,
                                    borderRadius: BorderRadius.circular(SU.setWidth(36)),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: SU.setFontSize(28),
                                  ),
                                ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  // 谁的通话，几人参加中
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MyText(
                          text: "${post.user?.nickname ?? "默认用户名"}の通話",
                          fontSize: 40,
                          color: Colors.green,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 10),
                      MyText(
                        text: "${post.conferenceCall?.conferenceCallUsers?.length ?? 0}人参加中",
                        fontSize: 33,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // 参加按钮
                  MyBtn(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call,
                          size: SU.setFontSize(62),
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        const MyText(
                          text: "加 入",
                          fontSize: 42,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // 空白占位，点击关闭当前页
        _buildBlankPlaceHolder(),
      ],
    );
  }

  /// 空白占位，点击后 pop
  _buildBlankPlaceHolder() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const SizedBox.expand(
          child: MyText(text: ""),
        ),
      ),
    );
  }

  /// 点击更多按钮，弹出底部弹窗
  _buildMoreBottomSheet() {}
}
