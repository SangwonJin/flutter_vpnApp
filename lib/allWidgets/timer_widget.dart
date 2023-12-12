import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.initTimerNow});

  final bool initTimerNow;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration duration = Duration();
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        duration = Duration(seconds: duration.inSeconds + 1);
      });
    });
  }

  stopTimer() {
    setState(() {
      timer?.cancel();
      timer = null;
      duration = Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null || !widget.initTimerNow) {
      widget.initTimerNow ? startTimer() : stopTimer();
    }
    String twoDigit(int number) => number.toString().padLeft(2, "0");
    final String minutes = twoDigit(duration.inMinutes.remainder(60));
    final String seconds = twoDigit(duration.inSeconds.remainder(60));
    final String hours = twoDigit(duration.inHours.remainder(60));

    return Text(
      "$hours: $minutes: $seconds",
      style: const TextStyle(
        fontSize: 23,
      ),
    );
  }
}
