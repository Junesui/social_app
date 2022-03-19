import 'package:flutter/material.dart';
import 'package:socialapp/widget/my_text.dart';
import 'package:timer_count_down/timer_count_down.dart';

class MyCountdown extends StatelessWidget {
  // 倒计时秒数，默认60s
  final int second;
  // 倒计时结束回调
  final VoidCallback? onFinished;

  const MyCountdown({Key? key, this.second = 60, this.onFinished}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: second,
      build: (BuildContext context, double time) => MyText(
        text: "(${time.toString().split(".")[0]})",
        fontSize: 36,
        color: Colors.grey,
      ),
      onFinished: onFinished,
    );
  }
}
