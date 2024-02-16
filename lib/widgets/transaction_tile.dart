import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

import '../utils/globals.dart';

class TransactionTile extends StatefulWidget {
  const TransactionTile(
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
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: open ? .95 : 1.0,
      alignment: Alignment.bottomCenter,
      curve: Curves.easeInOut,
      filterQuality: FilterQuality.high,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.only(
          bottom: open ? 25 : 4,
        ),
        child: Card(
          elevation: open ? 10 : 0,
          shadowColor: Colors.black.withOpacity(.29),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            onTap: () {
              widget.onPressed();
              setState(() {
                open = !open;
              });
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Card(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(0),
                                  topRight: Radius.circular(0))),
                          elevation: 0,
                          color: Globals.primaryColor,
                          child: SizedBox(
                            height: 60,
                            width: 80,
                            child: Center(
                              child: Text(
                                "N\$ 150.0",
                                style: Globals.whiteHeading,
                              ),
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
                                widget.title,
                                style: Globals.title,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 6.0, bottom: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Fee: ",
                                        style: Globals.subtitle,
                                      ),
                                      Text(
                                        "N\$ 1.56",
                                        style: TextStyle(
                                            color: Color(0xff505050),
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 46),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (false)
                                Icon(
                                  FontAwesomeIcons.moneyBillTransfer,
                                  size: 15,
                                  color: Colors.pink,
                                ),
                              Text(
                                "Done",
                                style: TextStyle(
                                  color: Color(0xff00aa00),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    color: const Color(0xffF3F1F5),
                    height: open ? 60 : 0,
                    width: double.infinity,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Card(
                                  margin: EdgeInsets.only(right: 5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(0),
                                          topRight: Radius.circular(0))),
                                  elevation: 0,
                                  color: Color(0xffF3F1F5),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.0, vertical: 18.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Text(
                                        "N\$ 2.0",
                                        style: Globals.title,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, top: 6.0, bottom: 2.0),
                                          child: Text(
                                            "Fees",
                                            style: Globals.title,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6, left: 26.0),
                                            child: Text(
                                              Jiffy.parseFromDateTime(
                                                      DateTime.now().subtract(
                                                          const Duration(
                                                              days: 65)))
                                                  .yMMMEdjm
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Color(0xffaaaaaa),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Card(
                              surfaceTintColor: Globals.primaryColor,
                              shape: const CircleBorder(),
                              color: Globals.white,
                              elevation: 6,
                              shadowColor:
                                  Globals.primaryColor.withOpacity(.09),
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Icon(
                                  Icons.touch_app,
                                  color: Color(0xffcccccc),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
