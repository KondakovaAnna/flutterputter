import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location.dart';
import 'package:myproject/classes/Plant.dart';
import 'globals.dart' as globals;
import 'package:myproject/plant_page.dart';

/*class SuperMarker {
  double latitude;
  double longitude;
  String info;
  SuperMarker({
    required this.latitude,
    required this.longitude,
    required this.info,
  });
}*/

var default_pin =
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
var selected_pin =
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);

class MarkerPlant {
  MarkerId mid;
  Plant_with_coordinate plant;
  MarkerPlant({
    required this.mid,
    required this.plant,
  });
}

class MapSample extends StatefulWidget {
  final LatLng initPos;
  MapSample(this.initPos);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  //Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  late int _markerIdCounter;
  final int _defIdValue = 0;
  final double zoom = 18.0;
  final Completer<GoogleMapController> _controller = Completer();
  List<Plant_with_coordinate> supa = [];
  List<Marker> markers = [];
  MarkerPlant? _selectedPlace;

  void unselect() {
    var marker_index = markers
        .indexWhere((element) => element.markerId == _selectedPlace!.mid);
    var new_marker = markers[marker_index];
    markers[marker_index] = new_marker.copyWith(iconParam: default_pin);
  }

  void _unselectPlace() {
    setState(() {
      unselect();
      _selectedPlace = null;
    });
  }

  void _selectPlace(MarkerPlant place) {
    setState(() {
      if (_selectedPlace != null) unselect();
      _selectedPlace = place;
      var marker_index = markers
          .indexWhere((element) => element.markerId == _selectedPlace!.mid);
      var new_marker = markers[marker_index];
      markers[marker_index] = new_marker.copyWith(iconParam: selected_pin);
    });
  }

  @override
  void initState() {
    super.initState();
    var plants = globals.list_of_plants;
    supa = plants;
    //for (var i = 1; i < 4; i++) {
    // supa.add(
    //Plant_with_coordinate(
    //p: Plant(
    //name: "name",
    //info: "info$i",
    // picture: 'assets/images/monstera(zoom).jpg',
    //),
    //latitude: widget.initPos.latitude + 0.25 * i,
    //longitude: widget.initPos.longitude + 0.25 * i,
    //time: DateTime.now(),
    //),
    //);
    //}
    markers = _convert(supa);
  }

  List<Marker> _convert(List<Plant_with_coordinate> supa) {
    List<Marker> res = [];
    for (var i in supa) {
      res.add(
        marker_from_pwc(i),
      );
    }
    return res;
  }

  Marker marker_from_pwc(Plant_with_coordinate pwc) {
    var mid = MarkerId(pwc.p.info);
    return Marker(
      infoWindow: InfoWindow(title: pwc.p.name),
      position: LatLng(pwc.latitude, pwc.longitude),
      icon: default_pin,
      markerId: mid,
      onTap: () => _selectPlace(MarkerPlant(mid: mid, plant: pwc)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: widget.initPos, zoom: zoom),
            markers: markers.toSet(),
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (_) => _unselectPlace(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 50.0),
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: const Icon(Icons.arrow_back_ios_rounded),
                //backgroundColor: const Color(0xFF89C09F),
                //child: const Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ),
          /*Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                heroTag: "add",
                onPressed: initState,
                backgroundColor: const Color(0xFF89C09F),
                child: const Icon(Icons.add),
              ),
            ),
          ),*/
          if (_selectedPlace != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 45.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PhysicalModel(
                  color: Colors.black,
                  shadowColor: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  elevation: 12,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PlantPage(_selectedPlace!.plant)));
                    },
                    child: Container(
                      width: 370.0,
                      height: 110.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(_selectedPlace!.plant.p.picture,
                              width: 150.0, fit: BoxFit.cover),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, top: 15.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    _selectedPlace!.plant.p.name,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontFamily: 'BoldMontserrat',
                                        fontSize: 18),
                                  ),
                                ),
                                Text(
                                    "${_selectedPlace!.plant.time.day.toString().padLeft(2, '0')}/${_selectedPlace!.plant.time.month.toString().padLeft(2, '0')}/${_selectedPlace!.plant.time.year.toString()}",
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
  }
}
