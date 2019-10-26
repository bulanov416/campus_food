import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String name;
  String type;
  DateTime expiration;
  LatLng location;
  List<Food> menu;
  int upvotes;
  DocumentReference creator;
  String id;

  Place(this.name, this.type, this.expiration, this.location, this.menu,
      this.upvotes, this.creator, this.id);


}

class Food<T extends String, double> {
  String name;
  double rating;
  List<T> cost;
  List<String> dietaryRestrictions;
  DocumentReference creator;

  Food(this.name, this.rating, this.cost, this.dietaryRestrictions,
      this.creator);


}