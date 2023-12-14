import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hospital/utils/globals.dart';

class RecommendationMap extends StatefulWidget {
  const RecommendationMap({super.key});

  @override
  State<RecommendationMap> createState() => _RecommendationMapState();
}

class _RecommendationMapState extends State<RecommendationMap>
    with TickerProviderStateMixin {
  late final GoogleMapController _mapController;
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
        target: LatLng(4.389721804770724, 18.54229163378477),
        bearing: 50,
        zoom: 16);
    super.initState();
  }

  late LatLng psn;

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      body: SizedBox(
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
    );
  }
}
