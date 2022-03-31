import 'package:flutter/cupertino.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

// 推流时候的本地预览ID
int? _previewViewID;
// 拉流时候的本地预览ID
int? _playViewID;

/// 即构 SDK 相关操作
class Zego {
  /// 1、创建引擎
  static void createEngine(int appID, {ZegoScenario zegoScenario = ZegoScenario.General}) {
    ZegoEngineProfile profile = ZegoEngineProfile(
      appID,
      zegoScenario,
      enablePlatformView: true,
    );
    ZegoExpressEngine.createEngineWithProfile(profile);
  }

  /// 2、登录房间
  static void loginRoom(String userId, String roomId, ZegoRoomConfig config) {
    // 创建用户对象
    ZegoUser user = ZegoUser.id(userId);
    // 登录房间
    ZegoExpressEngine.instance.loginRoom(roomId, user, config: config);
  }

  /// 3、推流
  static Widget? publishStream(String streamID, {bool isPreview = false}) {
    // 开始推流
    ZegoExpressEngine.instance.startPublishingStream(streamID);
    // 如果开启了(视频)本地渲染和预览
    if (isPreview) {
      // 创建本地渲染和预览
      Widget? previewViewWidget = ZegoExpressEngine.instance.createPlatformView((viewID) {
        _previewViewID = viewID;
        // 设置预览画布
        ZegoCanvas previewCanvas = ZegoCanvas.view(viewID);
        // 开始预览
        ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
      });
      return previewViewWidget;
    }
  }

  /// 4、拉流
  static Widget? playStream(String streamID, {bool isShowPlayStreamView = false}) {
    // 开始拉流
    ZegoExpressEngine.instance.startPlayingStream(streamID);
    // 如果开启了显示拉流画面
    if (isShowPlayStreamView) {
      Widget? playViewWidget = ZegoExpressEngine.instance.createPlatformView((viewID) {
        _playViewID = viewID;
        // 设置预览画布
        ZegoCanvas canvas = ZegoCanvas.view(viewID);
        // 开始渲染流
        ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
      });
      return playViewWidget;
    }
  }

  /// 5、停止推拉流
  /// 5.1、停止推流
  static void stopPublish() {
    // 停止推流
    ZegoExpressEngine.instance.stopPublishingStream();
    // 停止预览
    ZegoExpressEngine.instance.stopPreview();
    // 销毁本地预览 PlatformView
    if (_previewViewID != null) {
      ZegoExpressEngine.instance.destroyPlatformView(_previewViewID!);
    }
  }

  /// 5.2、停止拉流
  static void stopPlay(String streamID) {
    // 停止拉流
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    // 销毁本地预览 PlatformView
    if (_playViewID != null) {
      ZegoExpressEngine.instance.destroyPlatformView(_playViewID!);
    }
  }

  /// 6、退出房间
  static void logoutRoom(String roomID) {
    ZegoExpressEngine.instance.logoutRoom(roomID);
  }

  /// 7、销毁引擎
  static void destroyEngine() {
    ZegoExpressEngine.destroyEngine();
  }
}
