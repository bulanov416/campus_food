import 'package:campus_food/map_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './auth.dart';
import 'place_data.dart';

class NewPinCreator extends StatefulWidget {
  LatLng location;

  NewPinCreator(this.location);

  @override
  NewPinCreatorState createState() => NewPinCreatorState(location);
}

class NewPinCreatorState extends State<NewPinCreator> {
  static String name;
  LatLng location;
  List<bool> isSelectedToggleButton = [false, false];

  Place newPlace = new Place(
    name,
    'Pin',
    null,
    null,
    0,
    null,
    null,
    null
  );

  NewPinCreatorState(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create New",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder()),
                                  maxLength: 30,
                                  onChanged: (text) {
                                    name = text;
                                  },
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: _uploadButton(context),
    );
  }

  Widget _uploadButton(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime expire = DateTime(now.year, now.month, now.day+1, 0, 0, 0);
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('places').document().snapshots(),
      builder: (context, snapshot) {
        return FloatingActionButton(
          child: Icon(Icons.check),

          onPressed: () {
            if (Auth.user != null) {
              // UPLOAD newPlace OBJECT TO DATABASE
              // DONT FORGET TO TAKE DATA FROM location AND UPLOAD TO DATABASE WITH OBJECT
              snapshot.data.reference.setData({
                "name": name,
                "creator": Firestore.instance.collection('users').document(
                    Auth.user.uid),
                "downvoters": [],
                "upvoters": [],
                "timeToExpire": expire.millisecondsSinceEpoch,
                "expiration": expire,
                "type": "",
                "upvotes": 0,
                "location": new GeoPoint(location.latitude, location.longitude),
                "createdAt": now
              });
              Navigator.pop(context);
            } else {
              Auth.refreshFirebaseUser();
              Auth.SignInAlert(
                  context, "You need to be signed in to add pins to the map.");
            }
          },
        );
      }
    );
  }
}