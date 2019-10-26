import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String type;
  DateTime expiration;
  LatLng location;
  List<Food> menu;
  String metadata;
  int upvotes;
}

class Food<T extends String, double> {
  String name;
  double rating;
  List<T> cost;
  List<String> dietaryRestrictions;
}