import 'package:flutter/material.dart';
import 'package:socialapp/widget/my_text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// 正计时器
class MyCountup extends StatefulWidget {
  final double fontSize;

  const MyCountup({Key? key, this.fontSize = 36}) : super(key: key);

  @override
  _MyCountupState createState() => _MyCountupState();
}

class _MyCountupState extends State<MyCountup> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  // 初始化方法
  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  // 从渲染树中移除时调用的方法
  @override
  void deactivate() async {
    await _stopWatchTimer.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: _stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data!;
        final displayTime = StopWatchTimer.getDisplayTime(
          value,
          milliSecond: false,
        );
        return MyText(
          text: displayTime,
          fontSize: widget.fontSize,
          color: Colors.grey,
        );
      },
    );
  }
}
