import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/models/week_data.dart';
import 'package:hospital/utils/globals.dart';
import 'package:lottie/lottie.dart';

class WeeklyWidget extends StatefulWidget {
  const WeeklyWidget({super.key, required this.weekly});
  final WeekData weekly;

  @override
  State<WeeklyWidget> createState() => _WeeklyWidgetState();
}

class _WeeklyWidgetState extends State<WeeklyWidget> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return SizedBox(
      height: 250,
      width: size.width,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Lottie.asset("$dir/scroll4.json",
                        fit: BoxFit.contain, width: 100)),
                Material(
                  shadowColor: Colors.black.withOpacity(.35),
                  elevation: 0,
                  shape: Globals.radius(36),
                  color: Colors.white.withOpacity(.25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 170,
                                child: Text(widget.weekly.description)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Max Players",
                                  style: GoogleFonts.jost(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(.3)),
                                ),
                                Text(
                                  prettyNumber(widget.weekly.maxPlayers),
                                  style: GoogleFonts.damion(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const Text("100 CFA"),
                            ],
                          ),
                        ),
                        MaterialButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          shape: Globals.radius(26),
                          height: 50,
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            toast(message: "Entering");
                          },
                          child: const Text("Enter the Challenge"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
