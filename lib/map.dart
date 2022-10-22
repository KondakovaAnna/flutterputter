import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location.dart';

class SuperMarker {
  double latitude;
  double longitude;
  String info;
  SuperMarker({
    required this.latitude,
    required this.longitude,
    required this.info,
  });
}

class MapSample extends StatefulWidget {
  final LatLng initPos;

  MapSample(this.initPos);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  late int _markerIdCounter;
  final int _defIdValue = 0;
  final double zoom = 18.0;
  final Completer<GoogleMapController> _controller = Completer();
  List<SuperMarker> supa = [];

  @override
  void initState() {
    super.initState();
    for (var i = 1; i < 4; i++) {
      supa.add(
        SuperMarker(
            info: i.toString(),
            latitude: widget.initPos.latitude + 0.25 * i,
            longitude: widget.initPos.longitude + 0.25 * i),
      );
    }
  }

  Set<Marker> _convert(List<SuperMarker> supa) {
    Set<Marker> res = {};
    for (var i in supa) {
      res.add(
        Marker(
          infoWindow: InfoWindow(title: i.info),
          position: LatLng(i.latitude, i.longitude),
          markerId: MarkerId(i.info),
        ),
      );
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: widget.initPos, zoom: zoom),
            markers: _convert(supa),
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:16.0, top:50.0),
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: const Icon(Icons.arrow_back_ios_rounded),
                //backgroundColor: const Color(0xFF89C09F),
                //child: const Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                heroTag: "add",
                onPressed: _addMarker,
                backgroundColor: const Color(0xFF89C09F),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _markerIdVal({bool def = true}) {
    String val;
    if (def) {
      val = 'marker_id_$_defIdValue';
    } else {
      val = 'marker_id_$_markerIdCounter';
      _markerIdCounter++;
    }
    return val;
  }

  Future<void> moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17),
      ),
    );
    /*controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: zoom,
        ),
      ),
    );*/
  }

  Future<void> _addMarker() async {
    var pos = await determinePosition();
    SuperMarker newsupa = SuperMarker(
        info: "${pos.latitude}+${pos.longitude}",
        latitude: pos.latitude,
        longitude: pos.longitude);
    supa.add(newsupa);
    setState(() {});
  }

  Future<void> _goToMyPosition() async {
    var pos = await determinePosition();
    moveCamera(pos);
  }
}

/*Future<void> _goToMyPosition() async {
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
}*/
