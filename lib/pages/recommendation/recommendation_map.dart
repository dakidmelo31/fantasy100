import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hospital/utils/globals.dart';
import 'package:hospital/widgets/recommendation_carousel.dart';

class RecommendationMap extends StatefulWidget {
  const RecommendationMap({super.key});

  @override
  State<RecommendationMap> createState() => _RecommendationMapState();
}

class _RecommendationMapState extends State<RecommendationMap>
    with TickerProviderStateMixin {
  late final GoogleMapController _mapController;
  late CameraPosition initialCameraPosition;
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _visible = false;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
        target: LatLng(4.389721804770724, 18.54229163378477),
        bearing: 50,
        zoom: 16);
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
    super.initState();
  }

  late LatLng psn;

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  width: size.width,
                  height: size.height,
                  child: GoogleMap(
                    initialCameraPosition: initialCameraPosition,
                    onLongPress: (argument) {
                      setState(() {
                        psn = argument;
                        debugPrint(psn.toString());
                      });
                    },
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    buildingsEnabled: true,
                    onMapCreated: (controller) => setState(() {
                      _mapController = controller;
                    }),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 68.0),
                    child: MaterialButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      onPressed: () {
                        _animationController.forward();
                      },
                      textColor: Globals.primaryColor,
                      color: Colors.white,
                      shape: Globals.radius(16),
                      child: Text("See Recommendations"),
                      elevation: 20,
                    ),
                  ),
                ),
                RecommendationCarousel(
                  animation: _animation,
                  visibility: _visible,
                  visit: (p0) {
                    _mapController.animateCamera(CameraUpdate.newLatLng(p0));
                  },
                  callback: () {
                    setState(() {
                      _visible = false;
                      _animationController.reverse();
                    });
                  },
                )
              ],
            );
          }),
    );
  }
}
