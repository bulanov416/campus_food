import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'place_data.dart';

class MeetupView extends StatefulWidget {
  Meetup meetup;
  MeetupView(this.meetup);

  MeetupViewState createState() => MeetupViewState(meetup);
}

class MeetupViewState extends State<MeetupView> {
  Meetup meetup;

  MeetupViewState(this.meetup);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
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
                                child: Text('Meetup Members',
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
                  itemCount: meetup.members.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(meetup.members[i],
                                      style: TextStyle(fontSize: 15))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ]),
      ),
    );
  }
}