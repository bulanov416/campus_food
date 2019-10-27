import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'place_data.dart';
import 'place_view.dart';

class MapView extends StatefulWidget {
  @override
  MapViewState createState() => MapViewState();
}

Place nave = new Place(
  "North Ave",
  "Dining Hall",
  new DateTime(2019, 10, 27),
  LatLng(33.771261, -84.391391),
  25,
  null,
  "a01",
  null
);

class MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  double zoomVal = 5.0;
  Map<String, Place> places = {};
  List<Marker> allMarkers = [];
  List<String> addedDiningOptions = [];
//
//  void generateMarker(id, place) {
//    allMarkers.add(Marker(
//        markerId: MarkerId(place.id),
//        position: place.location,
//        infoWindow: InfoWindow(
//          title: place.name,
//          snippet: place.type,
//        ),
//        icon: BitmapDescriptor.defaultMarker,
//        onTap: () {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => (PlaceView(place)),
//              )
//          );
//        }
//    ));
//  }
//
//  void generateMarkers() {
//    allMarkers = [];
//    places.forEach(generateMarker);
//  }
//
//  void addPlaceToList(DocumentSnapshot doc) {
//    places[doc.documentID] = Place.fromSnapshot(doc);
//    doc.reference.collection("menu").snapshots()
//        .listen((data) => data.documents.forEach((doc2) =>
//        print(doc2["name"])));
//  }
//
//  void onReadDiningOptions(QuerySnapshot data) {
//    data.documents.forEach(addPlaceToList);
//
//    generateMarkers();
//  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: Icon(Icons.zoom_out),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          },
        )
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(Icons.zoom_in),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(33.777281, -84.398600), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(33.777281, -84.398600), zoom: zoomVal)));
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.1",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(946)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Closed \u00B7 Opens 17:00 Thu",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: _buildMap(context),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }

  Widget _buildMap(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection("places")
          .where("timeToExpire", isGreaterThan: DateTime.now().millisecondsSinceEpoch)
          .snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return new Text("Connecting...");
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:  CameraPosition(target: LatLng(33.776817, -84.398879), zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },

          markers: Set.from(_buildMarkers(context, snapshot.data.documents)),
          zoomGesturesEnabled: true,
        );
      }
    );
  }

    Marker _buildMarker(BuildContext context, DocumentSnapshot data) {
      Place place = Place.fromSnapshot(data);
      places[place.id] = place;
      return Marker(
          markerId: MarkerId(place.id),
          position: place.location,
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.type,
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (PlaceView(place)),
                )
            );
          }
      );
    }

  List<Marker> _buildMarkers(BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildMarker(context, data)).toList();
  }



}