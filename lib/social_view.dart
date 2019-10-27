import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './place_data.dart';
import 'meetup_view.dart';
import 'place_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Meetup meetup1 = new Meetup(
    "HackGT Lunch Squad",
    DateTime.now(),
    ["abulanov3@gatech.edu", "mryan3@gatech.edu", "smurali63@gatech.edu"],
    "North Ave");

Meetup meetup2 = new Meetup(
    "Dinner at Willage?",
    DateTime.now(),
    ["abulanov3@gatech.edu", "mryan3@gatech.edu", "smurali63@gatech.edu"],
    "West Village");

Meetup meetup3 = new Meetup(
    "Brittain Dinner",
    DateTime.now(),
    ["abulanov3@gatech.edu", "mryan3@gatech.edu", "smurali63@gatech.edu"],
    "Brittain");

class SocialView extends StatefulWidget {
  @override
  SocialViewState createState() => SocialViewState();
}

class SocialViewState extends State<SocialView> {
  List<Meetup> meetups = [meetup1, meetup2, meetup3];

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
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: meetups.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MeetupView(meetups[i])));
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
                                  Text(meetups[i].name,
                                      style: TextStyle(fontSize: 15))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(formatDate(meetups[i].dateTime),
                                      style: TextStyle(fontSize: 15))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(meetups[i].location,
                                      style: TextStyle(fontSize: 15))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ]),
    );
  }
}
