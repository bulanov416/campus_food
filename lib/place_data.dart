import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  String name;
  String type;
  DateTime expiration;
  LatLng location;
  List<Food> menu;
  int upvotes;
  DocumentReference creator;
  String id;
  final DocumentReference reference;

  Place.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['type'] != null),
        assert(map['location'] != null),
        assert(map['creator'] != null),
        assert(map['upvotes'] != null),
        assert(map['expiration'] != null),
        name = map['name'],
        type = map['type'],
        location = LatLng(map['location'].latitude, map['location'].longitude),
        creator = map['creator'],
        upvotes = map['upvotes'],
        expiration = new DateTime.fromMicrosecondsSinceEpoch(map['expiration'].seconds * 1000),
        id = reference.documentID;


  Place.fromSnapshot(DocumentSnapshot snapshot) :
    this.fromMap(snapshot.data, reference: snapshot.reference);

}

class Food {
  String name;
  double rating;
  String cost;
  List<String> dietaryRestrictions;
  DocumentReference creator;
  final DocumentReference reference;

  Food.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['name'] != null),
      assert(map['rating'] != null),
      assert(map['cost'] != null),
      assert(map['dietaryRestrictions'] != null),
      assert(map['creator'] != null),
      name = map['name'],
      rating = map['rating'],
      cost = map['cost'],
      dietaryRestrictions = map['dietaryRestrictions'],
      creator = map['creator'];

  Food.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}