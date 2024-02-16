import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hospital/utils/globals.dart';

class RecommendationCarousel extends StatefulWidget {
  const RecommendationCarousel(
      {super.key,
      required this.animation,
      required this.callback,
      required this.visit,
      required this.visibility});
  final bool visibility;
  final Animation<double> animation;
  final VoidCallback callback;
  final Function(LatLng) visit;

  @override
  State<RecommendationCarousel> createState() => _RecommendationCarouselState();
}

class _RecommendationCarouselState extends State<RecommendationCarousel>
    with TickerProviderStateMixin {
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0, keepPage: true);

  late bool _hide;
  @override
  void initState() {
    _hide = widget.visibility;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            top: 0,
            left: _hide ? size.width : 0,
            width: size.width,
            height: size.height,
            child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10 * widget.animation.value,
                  sigmaY: 10 * widget.animation.value,
                ),
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: PageView.builder(
                    pageSnapping: true,
                    controller: _controller,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: 20,
                    onPageChanged: (value) {
                      HapticFeedback.heavyImpact();
                    },
                    itemBuilder: (context, index) {
                      return FractionallySizedBox(
                        heightFactor: .55,
                        widthFactor: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Material(
                            elevation: 60,
                            shadowColor: Colors.black.withOpacity(.1),
                            color: Globals.white,
                            shape: Globals.radius(20),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 160,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://cdn.hashnode.com/res/hashnode/image/upload/v1684106916112/79224ba1-66e8-4bca-abbb-168bdca0c2f1.png?w=1600&h=840&fit=crop&crop=entropy&auto=compress,format&format=webp",
                                      placeholder: (context, url) =>
                                          placeholder,
                                      alignment: Alignment.center,
                                      errorWidget: (context, url, error) =>
                                          errorWidget2,
                                      width: double.infinity,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Marianie Sidney Shopping Mall",
                                    style: Globals.heading,
                                  ),
                                ),
                                const SizedBox(
                                  height: 120,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(26)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 16),
                                    onPressed: () {
                                      setState(() {
                                        _hide = !_hide;
                                      });
                                      widget.callback();
                                      widget.visit(LatLng(
                                          5, Random().nextInt(20).toDouble()));
                                    },
                                    elevation: 10,
                                    color: Globals.primaryColor,
                                    textColor: Colors.white,
                                    child: SizedBox(
                                      width: size.width * .8,
                                      child: const Center(
                                        child: Text(
                                          "Get Directions",
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )));
      },
    );
  }
}
