import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'place_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sprintf/sprintf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'food_or_friends_creator.dart';

class PlaceView extends StatefulWidget {
  final Place _place;

  PlaceView(this._place);

  PlaceViewState createState() => PlaceViewState(_place);
}

class PlaceViewState extends State<PlaceView> {
  Place _place;
  String upvoteValue = '';

  PlaceViewState(this._place);

  @override
  void initState() {
    upvoteValue = _place.upvotes.toString();
    super.initState();
  }

  String timeUntilExpiration() {
    print(_place.expiration.toString());
    return (_place.expiration.difference(DateTime.now()).inHours.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("places").document(_place.id).collection("menu").snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Text("Loading Data");
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(_place.name),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (FoodOrFriendsCreatorState(_place).build(context)))
                    );
                  },
                )
              ],
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text('Food',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text('Rating',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text('Price',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ))
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: _buildList(context, snapshot.data.documents),
                    ),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.arrow_upward),
                                              onPressed: () {
                                                _place.upvotes++;
                                                setState(() {
                                                  upvoteValue =
                                                      _place.upvotes.toString();
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(upvoteValue,
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.arrow_downward),
                                              onPressed: () {
                                                _place.upvotes--;
                                                setState(() {
                                                  upvoteValue =
                                                      _place.upvotes.toString();
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(timeUntilExpiration() + 'h left',
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: Icon(Icons.map),
                                        onPressed: () {
                                          _launchURL(sprintf(
                                              "http://maps.google.com/?q=%s,%s", [
                                            _place.location.latitude.toString(),
                                            _place.location.longitude.toString()
                                          ]));
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView (
      scrollDirection: Axis.vertical,
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    Food food = Food.fromSnapshot(data);
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(food.name,
                        style: TextStyle(fontSize: 25))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(food.rating.toString() + "/5",
                        style: TextStyle(fontSize: 25))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(food.cost,
                        style: TextStyle(fontSize: 25))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _launchURL(String u) async {
    String url = u;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}