import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './place_data.dart';
import 'meetup_view.dart';
import 'place_data.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './auth.dart';

//Meetup meetup1 = new Meetup(
//    "HackGT Lunch Squad",
//    DateTime.now(),
//    ["abulanov3@gatech.edu", "mryan3@gatech.edu", "smurali63@gatech.edu"],
//    Firestore.instance.collection('places').document("v7cUnjMREW1EYFT30tf1"), null, null);
//
//Meetup meetup2 = new Meetup(
//    "Dinner at Willage?",
//    DateTime.now(),
//    ["abulanov3@gatech.edu", "mryan3@gatech.edu", "smurali63@gatech.edu"],
//    Firestore.instance.collection('places').document("v7cUnjMREW1EYFT30tf1"), null, null);
//
//Meetup meetup3 = new Meetup(
//    "Brittain Dinner",
//    DateTime.now(),
//    ["abulanov3@gatech.edu", "mryan3@gatech.edu", "smurali63@gatech.edu"],
//    Firestore.instance.collection('places').document("v7cUnjMREW1EYFT30tf1"), null, null);

class SocialView extends StatefulWidget {
  @override
  SocialViewState createState() => SocialViewState();
}

class SocialViewState extends State<SocialView> {
  //List<Meetup> meetups = [meetup1, meetup2, meetup3];

  String formatDate(DateTime date) {
    return DateFormat("MM-dd-yy || hh:mm").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Flex(direction: Axis.vertical, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                  child: Row(children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('What',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    )
                  ],
                )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('When',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
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
                      child: Text('Where',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    )
                  ],
                )),
              ])))
        ]),
        _buildBody(context),
      ]),
    );
  }

  Widget _buildBody(BuildContext context, ) {
    if(Auth.user == null) {
      Auth.refreshFirebaseUser();
      return new Text("Sign in to access the social page");
    }
    return StreamBuilder<QuerySnapshot> (
      stream: Firestore.instance.collection("meetups").where("members", arrayContains: Auth.user.email).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Expanded(
            child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: _buildList(context, snapshot.data.documents)
            ),
          );
        } else {
          return new Container(height: 0, width: 0,);
        }
      }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
        scrollDirection: Axis.vertical,
        children: snapshot.map((data) => _buildItem(context, data)).toList()
    );
  }

  Widget _buildItem(BuildContext context, DocumentSnapshot snapshot) {
    Meetup meetup = Meetup.fromSnapshot(snapshot);
    if(snapshot == null || meetup == null) {
      return new Container(height: 0, width: 0);
    }
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MeetupView(meetup)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(meetup.name,
                        style: TextStyle(fontSize: 15))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(formatDate(meetup.dateTime),
                        style: TextStyle(fontSize: 15))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(meetup.location,
                      style: TextStyle(fontSize: 15))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}