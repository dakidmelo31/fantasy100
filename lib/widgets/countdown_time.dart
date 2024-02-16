import 'package:flutter/material.dart';
import 'package:hospital/widgets/ripple_dot.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../utils/globals.dart';
import 'time_ball.dart';

class CountdownTime extends StatefulWidget {
  const CountdownTime({super.key});

  @override
  State<CountdownTime> createState() => _CountdownTimeState();
}

class _CountdownTimeState extends State<CountdownTime> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return RawSlideCountdown(
      streamDuration: StreamDuration(
          config: const StreamDurationConfig(
              isCountUp: true,
              countUpConfig: CountUpConfig(initialDuration: Duration.zero))),
      builder: (context, duration, isCountUp) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text("Parking Duration", style: Globals.title),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimeBall(
                    child: Text(
                  "${duration.inHours}",
                  style: Globals.timeText,
                )),
                const SizedBox(
                  width: 15,
                ),
                const Text(" : "),
                const SizedBox(
                  width: 15,
                ),
                TimeBall(
                    child:
                        Text("${duration.inMinutes}", style: Globals.timeText)),
                const Text(" : "),
                const SizedBox(
                  width: 15,
                ),
                TimeBall(
                    child: Text("${duration.inSeconds % 60}",
                        style: Globals.timeText)),
              ],
            ),
            const SizedBox(height: kTextTabBarHeight, child: RippleDot()),
          ],
        );
      },
    );
  }
}
