import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/models/cash_model.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import '../models/Cash.dart';
import '../utils/globals.dart';

class CashTile extends StatefulWidget {
  const CashTile(
      {super.key, this.fromSearch, required this.index, required this.cash});
  final CashModel cash;
  final int index;
  final bool? fromSearch;

  @override
  State<CashTile> createState() => _CashTileState();
}

class _CashTileState extends State<CashTile> with TickerProviderStateMixin {
  bool opened = false;

  late AnimationController _controller;
  late int index;
  @override
  void initState() {
    index = widget.index;
    index = Random().nextInt(Colors.primaries.length);

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    final cash = widget.cash;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          elevation: 10,
          color: Globals.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Center(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: cash.image,
                          alignment: Alignment.center,
                          width: 60,
                          placeholder: (context, url) => placeholder,
                          errorWidget: (context, url, error) => errorWidget2,
                          height: 60,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${!cash.deposit ? " -" : " +"}${NumberFormat().format(cash.amount.toInt())} CFA",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            // fontSize: 18,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "${cash.agent}",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400,
                                  color:
                                      !cash.deposit ? Colors.grey : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Card(
                              elevation: 8.0,
                              shadowColor: (cash.status == "PENDING"
                                      ? Colors.amber
                                      : cash.status == "FAILED"
                                          ? Colors.pink
                                          : Globals.primaryColor)
                                  .withOpacity(.75),
                              shape: const CircleBorder(),
                              color: cash.status == "PENDING"
                                  ? Colors.amber
                                  : cash.status == "FAILED"
                                      ? Colors.pink
                                      : Globals.primaryColor,
                              child: const SizedBox(height: 10.0, width: 10.0),
                            ),
                            Icon(
                              !cash.deposit
                                  ? Icons.trending_down_rounded
                                  : Icons.trending_up_rounded,
                              size: 30,
                              color: !cash.deposit ? Colors.pink : Colors.blue,
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Jiffy(cash.createdAt).yMMMEd',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
