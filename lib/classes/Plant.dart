import 'dart:async';

import 'package:flutter/material.dart';

class Plant {
  String name;
  String info;
  String picture;
  Plant({
    required this.name,
    required this.picture,
    required this.info,
  });
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
        name: json["plantname"].replaceAll("('", '').replaceAll("',)", ''),
        info: json["plantinfo"].replaceAll("('", '').replaceAll("',)", ''),
        picture: json["picture"].replaceAll("('", '').replaceAll("',)", ''));
  }
}

class Plant_with_coordinate {
  Plant p;
  double latitude;
  double longitude;
  DateTime time;
  Plant_with_coordinate({
    required this.p,
    required this.latitude,
    required this.longitude,
    required this.time,
  });
  factory Plant_with_coordinate.fromPlant(Plant plant, lat, lon, t) {
    return Plant_with_coordinate(
        latitude: lat,
        longitude: lon,
        time: t,
        p: plant); //на сервере пихать json в json
  }
  factory Plant_with_coordinate.fromJson(Map<String, dynamic> json) {
    return Plant_with_coordinate(
        latitude: json["latitude"],
        longitude: json["longitude"],
        time: DateTime.parse(json["date"]),//**
        p: Plant.fromJson(json["plant"])); //на сервере пихать json в json
  }
}
