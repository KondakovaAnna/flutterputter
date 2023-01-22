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
}

class Plant_with_coordinate {
  Plant p;
  double latitude;
  double longitude;
  Plant_with_coordinate({
    required this.p,
    required this.latitude,
    required this.longitude,
  });
}