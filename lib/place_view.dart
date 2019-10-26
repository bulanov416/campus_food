import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'place_data.dart';

class PlaceView extends StatefulWidget {
  final Place _place;

  PlaceView(this._place);

  PlaceViewState createState() => PlaceViewState(_place);
}

class PlaceViewState extends State<PlaceView> {
  Place _place;

  PlaceViewState(this._place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_place.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TO-DO: Implement add food feature
            },
          )
        ],
      ),
      body:  new ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _place.menu.length,
          itemBuilder: (BuildContext context, int i) {
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_place.menu[i].name),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(_place.menu[i].rating.toString()),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(_place.menu[i].cost),
                      ),
                    ],
                  )
                )
              ],
            );
          }
      ),
    );
  }
}