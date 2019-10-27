import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'place_data.dart';
import './auth.dart';

class RateFood extends StatefulWidget {
  final Food food;
  final Place place;

  RateFood(this.food, this.place);

  RateFoodState createState() => new RateFoodState(food, place);
}

class RateFoodState extends State<RateFood> {
  Food food;
  Place place;
  double rating = 0;
  int starCount = 5;

  RateFoodState(this.food, this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Rate The Food"),
      ),
      body:
      new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(
              top: 50.0,
              bottom: 50.0,
            ),
            child: new StarRating(
              size: 25.0,
              rating: rating,
              color: Colors.orange,
              borderColor: Colors.grey,
              starCount: starCount,
              onRatingChanged: (rating) => setState(
                    () {
                  this.rating = rating;
                },
              ),
            ),
          ),
          new Text(
            "Food Rating: $rating",
            style: new TextStyle(fontSize: 30.0),
          ),
        ],
      ),
      floatingActionButton: _uploadButton(context),
    );
  }

  Widget _uploadButton(BuildContext context) {
    print(place.id);
    return StreamBuilder<DocumentSnapshot> (
      stream: Firestore.instance.collection("places").document(place.id).collection("menu").document(food.id).snapshots(),
      builder: (context, snapshot) {
        return FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            if (Auth.user != null) {
              // Send rating data (in variable rating) to the database
              if(snapshot.data["raters"].contains(Auth.user.uid)) {
                // TODO FIX THIS NOT ACTUALLY TELLING ANYTHING TO THE USER
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("Already rated food"),
                        content: new Text("You can only rate each food once."),
                        actions: <Widget>[
                          new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }
                          )
                        ],
                      );
                    }
                );
              } else {
                int length = snapshot.data["raters"].length;
                double curr = snapshot.data["rating"];
                snapshot.data.reference.updateData({
                  "rating": ((curr * (length / (length + 1))) +
                      (rating / (length + 1))),
                  "raters": FieldValue.arrayUnion([Auth.user.uid])
                });
              }

              Navigator.pop(context);
            } else {
              Auth.refreshFirebaseUser();
              Auth.SignInAlert(context,
                  "You have to sign in before you can give food a rating.");
            }
          },
        );
      }
    );
  }
}