import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socialapp/constant/common/style_constant.dart';
import 'package:socialapp/constant/home_constant.dart';
import 'package:socialapp/model/home/home_calling_model.dart';
import 'package:socialapp/model/home/home_content_model.dart';
import 'package:socialapp/net/dao/home_dao.dart';
import 'package:socialapp/page/home/home_float_room.dart';
import 'package:socialapp/page/home/home_room_item.dart';
import 'package:socialapp/router/router_name.dart';
import 'package:socialapp/util/bottom_sheet_util.dart';
import 'package:socialapp/util/date_util.dart';
import 'package:socialapp/util/screen_util.dart';
import 'package:socialapp/widget/my_avatar.dart';
import 'package:socialapp/widget/my_divider.dart';
import 'package:socialapp/widget/my_icon_btn.dart';
import 'package:socialapp/widget/my_loading_container.dart';
import 'package:socialapp/widget/my_pull_to_refresh.dart';
import 'package:socialapp/widget/my_text.dart';

/// 首页的 TabBarView
class HomeTabView extends StatefulWidget {
  // 类型 [HomeConstant.tabBarTypes]
  final int type;

  const HomeTabView({Key? key, required this.type}) : super(key: key);

  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> with AutomaticKeepAliveClientMixin {
  // 通话中的实体
  HomeCallingModel callingModel = HomeCallingModel();
  // 用户发布内容的实体
  HomeContentModel contentModel = HomeContentModel();
  List<PostContents> postContents = [];
  // 下拉刷新控制器
  final List<RefreshController> _refreshControllerList = [];
  // 列表滚动控制器
  final ScrollController _scrollController = ScrollController();
  // 数据加载状态
  bool _isLoading = true;

  // 初始化方法
  @override
  void initState() {
    super.initState();
    // 初始化下拉刷新控制器
    for (final type in HomeConstant.tabBarTypes) {
      _refreshControllerList.add(RefreshController(initialRefresh: false));
    }
    _getHomeData();
  }

  // 销毁方法
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 保持状态
  @override
  bool get wantKeepAlive => true;

  // 获取首页数据
  _getHomeData() async {
    await _getChatRooms();
    await _getPostContents();
    setState(() {
      _isLoading = false;
    });
  }

  // 获取聊天室房间
  _getChatRooms() async {
    await HomeDao.getCallingTimeLine().then((model) {
      setState(() {
        callingModel = model;
      });
    });
  }

  // 获取发表的内容
  _getPostContents({bool isLoadMore = false}) async {
    await HomeDao.getPostContent().then((model) {
      setState(() {
        if (isLoadMore) {
          contentModel.posts?.addAll(model.posts ?? []);
        } else {
          contentModel = model;
          postContents = [];
        }
        contentModel.posts?.forEach((post) {
          if (post.postType == null) {
            postContents.add(post);
          }
        });
      });
    });
  }

  // 下拉刷新
  _onRefresh() {
    int index = HomeConstant.tabBarTypes.indexOf(widget.type);
    try {
      _getChatRooms();
      _getPostContents();
      _refreshControllerList[index].refreshCompleted();
    } catch (e) {
      _refreshControllerList[index].refreshFailed();
    }
  }

  // 上拉加载
  _onLoading() {
    int index = HomeConstant.tabBarTypes.indexOf(widget.type);
    try {
      _getPostContents(isLoadMore: true);
      if (mounted) setState(() {});
      _refreshControllerList[index].loadComplete();
    } catch (e) {
      _refreshControllerList[index].loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MyLoadingContainer(
      isLoading: _isLoading,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: MyPullToRefresh(
          refreshController: _refreshControllerList[HomeConstant.tabBarTypes.indexOf(widget.type)],
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
              controller: _scrollController,
              itemCount: postContents.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // 通话房间水平列表
                  return _buildCallRooms();
                } else {
                  // 发布的内容
                  return _buildPublishContent(postContents[index - 1]);
                }
              }),
        ),
      ),
    );
  }

  /// 通话房间水平列表
  _buildCallRooms() {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 8),
      margin: const EdgeInsets.only(bottom: 20),
      height: SU.setHeight(300),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.1,
          ),
        ),
      ),
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          // 创建房间
          SliverToBoxAdapter(
            child: _buildCallRoomBothEnds(Icons.add_ic_call, () {
              _buildPostCall();
            }, "发布通话", 50, 30),
          ),
          // 中间房间列表
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return callingModel.posts == null
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return HomeFloatRoom(posts: callingModel.posts!, index: index);
                              });
                        },
                        child: HomeRoomItem(post: callingModel.posts![index]),
                      );
              },
              childCount: callingModel.posts?.length ?? 0,
            ),
          ),
          // 查看更多
          SliverToBoxAdapter(
            child: _buildCallRoomBothEnds(Icons.more_horiz, () {
              Navigator.of(context).pushNamed(RouterName.callTimeline);
            }, "查看更多", 50, 50),
          ),
        ],
      ),
    );
  }

  /// 通话房间两端的子项
  _buildCallRoomBothEnds(
      IconData icon, VoidCallback onTap, String text, double left, double right) {
    return Padding(
      padding: EdgeInsets.only(
        left: SU.setWidth(left),
        right: SU.setWidth(right),
        bottom: 2,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  width: SU.setWidth(150),
                  height: SU.setHeight(150),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300] ?? Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(SU.setHeight(75)),
                  ),
                  child: Icon(icon, color: Colors.green),
                ),
              ),
            ),
          ),
          MyText(
            text: text,
            color: Colors.grey,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  /// 用户发表的内容列表子项
  _buildPublishContent(PostContents content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SU.setWidth(StyleConstant.mainLRPadding)),
      child: Column(
        children: [
          // 内容
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左侧用户头像
              MyAvatar(
                userId: content.user!.id!,
                avatarUrl: content.user?.profileIconThumbnail,
              ),
              const SizedBox(width: 12),
              // 右侧内容
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 用户昵称和发布时间
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 用户昵称
                        Expanded(
                          child: MyText(
                            text: "${content.user!.nickname}",
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 发布时间
                        MyText(
                          text: DateUtil.format(content.createdAt!),
                          color: Colors.grey,
                          fontSize: 36,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 发布内容
                    MyText(
                      text: "${content.text}",
                      fontSize: 40,
                    ),
                    const SizedBox(height: 12),
                    // 底部按钮
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 左侧三个图标按钮
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // 点赞
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  MyIconBtn(
                                    onTap: () {},
                                    icon: AntDesign.like2,
                                    color: Colors.grey,
                                    size: 46,
                                  ),
                                  const SizedBox(width: 2),
                                  const MyText(
                                    text: "12",
                                    color: Colors.grey,
                                    fontSize: 33,
                                  ),
                                ],
                              ),
                              // 评论
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  MyIconBtn(
                                    onTap: () {},
                                    icon: Octicons.comment,
                                    color: Colors.grey,
                                    size: 42,
                                  ),
                                  const SizedBox(width: 2),
                                  const MyText(
                                    text: "53",
                                    color: Colors.grey,
                                    fontSize: 33,
                                  ),
                                ],
                              ),
                              // 分享
                              MyIconBtn(
                                onTap: () {},
                                icon: Ionicons.share_social_outline,
                                color: Colors.grey,
                                size: 46,
                              ),
                            ],
                          ),
                        ),
                        // 右侧图标按钮
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MyIconBtn(
                                onTap: () {
                                  _buildMoreBottomSheet(content);
                                },
                                icon: Feather.more_vertical,
                                color: Colors.grey,
                                size: 60,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 分割线
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 20),
            child: MyDivider(
              thickness: 5,
              color: Colors.grey[100],
            ),
          ),
        ],
      ),
    );
  }

  /// 发布通话
  _buildPostCall() {
    List<BottomSheetParam> params = [];
    params.add(BottomSheetParam(text: "语音聊天"));
    params.add(BottomSheetParam(text: "视频聊天"));
    BottomSheetUtil.show(context, params);
  }

  /// 更多按钮
  _buildMoreBottomSheet(PostContents content) {
    List<BottomSheetParam> params = [];
    params.add(BottomSheetParam(text: "屏蔽该用户"));
    params.add(BottomSheetParam(text: "举报"));
    params.add(BottomSheetParam(text: "聊天"));
    BottomSheetUtil.show(context, params);
  }
}
