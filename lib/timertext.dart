import 'package:baklandoro/notifier/timer.dart';
import 'package:baklandoro/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    var workTimer = Provider.of<WorkTimer>(context, listen: true);
    return Text(
      workTimer.isRunning ? formatDuration(workTimer.durationPassed) : '00:00:00',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 82.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
