import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location.dart';

class MapSample extends StatefulWidget {
  final LatLng initPos;

  MapSample(this.initPos);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {
    print("Sample started");
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: widget.initPos
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToMyPosition,
      ),
    );
  }

  Future<void> _goToMyPosition() async {
    final GoogleMapController controller = await _controller.future;
    var pos = await determinePosition();
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: pos,
        ),
      ),
    );
  }
}
