import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/globals.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.fees,
      required this.subtitle,
      required this.icon});
  final VoidCallback onPressed;
  final String title;
  final String fees;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black.withOpacity(.09),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(0))),
                  elevation: 0,
                  color: Globals.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 26),
                    child: Icon(
                      icon,
                      size: 20,
                      color: Globals.white,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 6.0, bottom: 2.0),
                      child: Text(
                        title,
                        style: Globals.title,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 0),
                      child: Text(
                        subtitle,
                        style: Globals.subtitle,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, top: 6.0, bottom: 2.0),
                      child: Text(
                        fees,
                        style: Globals.feeText,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Card(
              surfaceTintColor: Globals.primaryColor,
              shape: CircleBorder(),
              color: Globals.white,
              elevation: 6,
              shadowColor: Globals.primaryColor.withOpacity(.09),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Icon(
                  FontAwesomeIcons.chevronRight,
                  color: Globals.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
