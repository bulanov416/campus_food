import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String name;
  String type;
  DateTime expiration;
  LatLng location;
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
        expiration = new DateTime.fromMillisecondsSinceEpoch(map['expiration'].seconds * 1000),
        id = reference.documentID;


  Place.fromSnapshot(DocumentSnapshot snapshot) :
    this.fromMap(snapshot.data, reference: snapshot.reference);


  Place(this.name, this.type, this.expiration, this.location,
      this.upvotes, this.creator, this.id, this.reference);

}

class Food {
  String name;
  double rating;
  String cost;
  List<dynamic> dietaryRestrictions;
  DocumentReference creator;
  String id;

  final DocumentReference reference;

  Food.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['name'] != null),
      assert(map['rating'] != null),
      assert(map['cost'] != null),
      assert(map['dietary restrictions'] != null),
      assert(map['creator'] != null),
      name = map['name'],
      rating = map['rating'].toDouble(),
      cost = map['cost'],
      dietaryRestrictions = map['dietary restrictions'],
      creator = map['creator'],
      id = reference.documentID;

  Food.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);


  Food(this.name, this.rating, this.cost, this.dietaryRestrictions,
      this.creator, this.id, this.reference);

}

class Meetup {
  String name;
  DateTime dateTime;
  List<String> members;
  String location;

  Meetup(this.name, this.dateTime, this.members, this.location);

}
