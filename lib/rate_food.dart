import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'place_data.dart';
import 'place_view.dart';

class RateFood extends StatefulWidget {
  final Food food;

  RateFood(this.food);

  RateFoodState createState() => new RateFoodState(food);
}

class RateFoodState extends State<RateFood> {
  Food food;
  double rating = 0;
  int starCount = 5;

  RateFoodState(this.food);

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // Send rating data (in variable rating) to the database
          Navigator.pop(context);
        },
      ),
    );
  }
}