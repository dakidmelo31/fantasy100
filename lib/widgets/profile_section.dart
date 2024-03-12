import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital/pages/account/my_account.dart';
import 'package:hospital/pages/startup/SignupPage.dart';
import 'package:hospital/pages/transactions/topup_page.dart';
import 'package:hospital/providers/data_provider.dart';
import 'package:hospital/utils/transitions.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../utils/globals.dart';
import 'parking_tile.dart';

class ProfileSection extends StatelessWidget {
  final VoidCallback toggleSignup;

  const ProfileSection(
      {super.key,
      required this.maxHeight,
      required this.maxWidth,
      required this.value,
      required this.toggleSignup,
      this.isView = false,
      this.onVerticalDragUpdate,
      this.onVerticalDragEnd,
      required this.closeCallback});
  final VoidCallback? closeCallback;
  final double maxHeight, maxWidth;
  final double value;
  final bool isView;
  final void Function(DragUpdateDetails details)? onVerticalDragUpdate;
  final void Function(DragEndDetails details)? onVerticalDragEnd;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: true);
    final size = getSize(context);
    final managers = data.managers;
    return Padding(
      padding: EdgeInsets.only(
        top: lerpDouble(30.0, 0, value)!,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: lerpDouble(size.width * .05, 0, value)!),
        child: SizedBox(
          width: lerpDouble(size.width * .9, size.width, value)!,
          child: Material(
              color: Colors.transparent,
              elevation: 0,
              clipBehavior: Clip.hardEdge,
              shape: Globals.radius(lerpDouble(30, 0, value)!),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: lerpDouble(size.width * .0, 0, value)!),
                    child: SizedBox(
                      height: maxHeight,
                      width: lerpDouble(size.width * .9, maxWidth, value)!,
                      child: Padding(
                        padding: EdgeInsets.all(lerpDouble(20, 0, value)!),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  lerpDouble(30, 0, value)!)),
                          padding: EdgeInsets.symmetric(
                              horizontal: lerpDouble(20, 10, value)!,
                              vertical: 25),
                          child: Column(
                            children: [
                              //HEADER
                              Padding(
                                padding: EdgeInsets.only(
                                    top: lerpDouble(0, kToolbarHeight, value)!),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    data.me != null
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text("Hello"),
                                                  Text(
                                                    " Mr Melo FC",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Text("32,000 CFA")
                                            ],
                                          )
                                        : const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Welcome to "),
                                                  Text(
                                                    "${Globals.appName}",
                                                    style: Globals.title,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Now Connect & Win",
                                                style: Globals.subtitle,
                                              )
                                            ],
                                          ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            LeftTransition(
                                                child: const MyAccount()));
                                      },
                                      child: SizedBox(
                                        width: lerpDouble(70, 50, value),
                                        height: 60,
                                        child: Stack(
                                          children: [
                                            Opacity(
                                              opacity: 1 - value,
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                  width: 50,
                                                  height: 50,
                                                  imageUrl:
                                                      Globals.photoPlaceholder,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          errorWidget2,
                                                  placeholder: (context, url) =>
                                                      placeholder,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            if (auth.currentUser == null)
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Card(
                                                  elevation:
                                                      lerpDouble(0, 20, value),
                                                  shadowColor: Colors.black
                                                      .withOpacity(.25),
                                                  surfaceTintColor:
                                                      Colors.transparent,
                                                  color: Colors.white,
                                                  shape: const CircleBorder(),
                                                  child: InkWell(
                                                    customBorder:
                                                        const CircleBorder(),
                                                    onTap: toggleSignup,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          lerpDouble(
                                                              14, 8, value)!),
                                                      child: Icon(
                                                        FontAwesomeIcons.signIn,
                                                        size: lerpDouble(
                                                            15, 25, value),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            else
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Card(
                                                  elevation:
                                                      lerpDouble(0, 20, value),
                                                  shadowColor: Colors.black
                                                      .withOpacity(.25),
                                                  surfaceTintColor:
                                                      Colors.transparent,
                                                  color: Colors.white,
                                                  shape: const CircleBorder(),
                                                  child: InkWell(
                                                    customBorder:
                                                        const CircleBorder(),
                                                    onTap: () {
                                                      HapticFeedback
                                                          .heavyImpact();
                                                      Navigator.push(
                                                          context,
                                                          LeftTransition(
                                                              child:
                                                                  const TopUp()));
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          lerpDouble(
                                                              14, 8, value)!),
                                                      child: Icon(
                                                        FontAwesomeIcons.plus,
                                                        size: lerpDouble(
                                                            15, 25, value),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (value >= .3) const SizedBox(height: 50),

                              //BoDY
                              Flexible(
                                child: GestureDetector(
                                  onVerticalDragUpdate: onVerticalDragUpdate,
                                  onVerticalDragEnd: onVerticalDragEnd,
                                  child:
                                      NotificationListener<ScrollNotification>(
                                    onNotification: (scrollNotification) {
                                      if (scrollNotification
                                              is ScrollEndNotification &&
                                          scrollNotification
                                                  .metrics.extentAfter ==
                                              0) {
                                        HapticFeedback.heavyImpact();
                                        data.loadFantasyGroup(more: true);
                                      }
                                      return false;
                                    },
                                    child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: managers.length,
                                        itemExtent:
                                            (MediaQuery.of(context).size.width /
                                                    5) -
                                                lerpDouble(0, 10, value)!,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        itemBuilder: (context, index) {
                                          final manager = managers[index];
                                          return PlayerTile(
                                              index: index, manager: manager);
                                        }),
                                  ),
                                ),
                              ),

                              if (false)
                                if (data.loadingManagers)
                                  AnimatedContainer(
                                      duration: Globals.mainDuration,
                                      color: Globals.transparent,
                                      curve: Curves.fastEaseInToSlowEaseOut,
                                      width: double.infinity,
                                      height: data.loadingManagers ? 20 : 0,
                                      child:
                                          Lottie.asset("$dir/loading5.json")),

                              if (value >= .5)
                                FloatingActionButton(
                                  onPressed: closeCallback,
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  child: const Icon(
                                    FontAwesomeIcons.xmark,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
