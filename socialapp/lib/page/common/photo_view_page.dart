import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:socialapp/widget/my_cache_net_img.dart';

/// (点击图片)查看大图页面
class PhotoViewPage extends StatefulWidget {
  final Map arguments;
  // arguments 说明:
  // List<String> imgUrls - 图片URL列表;
  // int index - 被点击图片在图片URL列表中的index;
  // bool isHiddenCloseBtn - 是否隐藏关闭按钮[默认 true];

  const PhotoViewPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  // 控制器
  PageController _pageController = PageController(initialPage: 0);
  // 当前页Index
  int _currentIndex = 0;
  // 选中图片下面的原点指示器颜色
  static const Color _selColor = Colors.white;
  // 其他图片的原点指示器颜色
  static const Color _otherColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.arguments["index"]);
    _currentIndex = widget.arguments["index"];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildImg(),
          _buildCloseBtn(),
          _buildDotIndicator(),
        ],
      ),
    );
  }

  /// 图片
  _buildImg() {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.black,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          onLongPress: () {},
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: MyCacheNetImg.provider(widget.arguments["imgUrls"][index]),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            itemCount: widget.arguments["imgUrls"].length,
            loadingBuilder: (context, event) => const Center(
              child: SizedBox(
                width: 28.0,
                height: 28.0,
                child: CircularProgressIndicator(color: Colors.grey),
              ),
            ),
            backgroundDecoration: null,
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  /// 关闭按钮
  _buildCloseBtn() {
    return Positioned(
      top: 20,
      right: 20,
      height: 20,
      child: Offstage(
        offstage: widget.arguments["isHiddenCloseBtn"] ?? true,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.close,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// 底部圆点指示器
  _buildDotIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: widget.arguments["imgUrls"].length == 1 ? 0 : 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.arguments["imgUrls"].length,
            (index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(
                  radius: 3,
                  backgroundColor: index == _currentIndex ? _selColor : _otherColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
