import 'package:flutter/material.dart';
import 'package:socialapp/widget/my_text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// 正计时器
class MyCountup extends StatefulWidget {
  final double fontSize;

  const MyCountup({Key? key, this.fontSize = 45}) : super(key: key);

  @override
  _MyCountupState createState() => _MyCountupState();
}

class _MyCountupState extends State<MyCountup> {
  static final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  // 初始化方法
  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  // 销毁方法
  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
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
        );
      },
    );
  }
}
