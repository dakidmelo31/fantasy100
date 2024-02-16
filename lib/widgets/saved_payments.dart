import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/utils/globals.dart';

class SavedPayments extends StatefulWidget {
  const SavedPayments({super.key});

  @override
  State<SavedPayments> createState() => _SavedPaymentsState();
}

class _SavedPaymentsState extends State<SavedPayments> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Column(
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 253, 252, 255),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  begin: Alignment.topLeft,
                  stops: [.8, 1.0],
                  end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                    blurRadius: 26,
                    color: Colors.black.withOpacity(.0155),
                    spreadRadius: .9,
                    offset: Offset(6, 16)),
              ],
              borderRadius: BorderRadius.circular(16)),
          width: size.width * .9,
          height: 170,
          duration: Duration(milliseconds: 700),
          curve: Curves.fastLinearToSlowEaseIn,
          alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  "Visa",
                  style: TextStyle(
                      color: Globals.primaryColor, fontWeight: FontWeight.w700),
                ),
              ),
              Positioned(
                top: 20,
                right: 0,
                child: Card(
                  shape: CircleBorder(),
                  color: Globals.primaryColor,
                  elevation: 10,
                  shadowColor: Globals.primaryColor.withOpacity(.08),
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                    },
                    customBorder: CircleBorder(),
                    child: Icon(
                      Icons.chevron_right,
                      color: Globals.white,
                      size: 45,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 20,
                child: Text(
                  "0219 3022 3300 6594",
                  style: GoogleFonts.orbitron(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Globals.primaryColor),
                ),
              ),
              Positioned(
                top: 120,
                left: 20,
                child: Text(
                  "05 / 33",
                  style: GoogleFonts.orbitron(color: Globals.primaryColor),
                ),
              ),
              Positioned(
                top: 120,
                right: 20,
                child: Text(
                  "053",
                  style: GoogleFonts.orbitron(color: Globals.primaryColor),
                ),
              ),
              if (false)
                Positioned(
                  top: 45,
                  right: 10,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.eye,
                            size: 16,
                          )),
                      MaterialButton(
                          elevation: 0,
                          enableFeedback: true,
                          focusElevation: 7,
                          hoverElevation: 7,
                          highlightElevation: 10,
                          visualDensity: VisualDensity.comfortable,
                          padding: EdgeInsets.only(
                              left: 0, right: 0, top: 16, bottom: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          color: Globals.primaryColor,
                          textColor: Globals.white,
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                          },
                          child: Row(
                            children: [
                              Text("Use "),
                              Icon(
                                FontAwesomeIcons.chevronRight,
                                color: Globals.white,
                                size: 14,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
