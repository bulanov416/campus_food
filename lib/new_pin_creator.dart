import 'package:campus_food/map_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'frame.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // UPLOAD newPlace OBJECT TO DATABASE
          // DONT FORGET TO TAKE DATA FROM location AND UPLOAD TO DATABASE WITH OBJECT
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FrameState().build(context),
              ));
        },
      ),
    );
  }
}