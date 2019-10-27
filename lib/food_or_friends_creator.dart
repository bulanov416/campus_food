import 'package:campus_food/map_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sprintf/sprintf.dart';
import 'frame.dart';
import 'place_data.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class FoodOrFriendsCreator extends StatefulWidget {
  Place currentPlace;

  FoodOrFriendsCreator(this.currentPlace);

  @override
  FoodOrFriendsCreatorState createState() => FoodOrFriendsCreatorState(currentPlace);
}

class FoodOrFriendsCreatorState extends State<FoodOrFriendsCreator> {
  String name;
  Place currentPlace;
  List<bool> isSelectedToggleButton = [true, false];
  bool isFoodSelection = true;
  String dropdownValue = '';

  static String foodName;
  static double foodRating = 5.0;
  static String foodCost;
  static List<dynamic> foodDietaryRestrictions;

  Food newFood = new Food(
      foodName,
      foodRating,
      foodCost,
      foodDietaryRestrictions,
      null,
      null
  );

  static String meetupName;
  static DateTime meetupDateTime;
  static List<String> meetupMembers;

  Meetup newMeetup = new Meetup(
    meetupName,
    meetupDateTime,
    meetupMembers,
    null
  );




  FoodOrFriendsCreatorState(this.currentPlace);

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
                                child: ToggleButtons(
                                  children: <Widget>[
                                    Text(
                                      'Food',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'Friends',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                  onPressed: (int i) {
                                    setState(() {
                                      for (int buttonIndex = 0; buttonIndex < isSelectedToggleButton.length; buttonIndex++) {
                                        if (buttonIndex == i) {
                                          isSelectedToggleButton[buttonIndex] = true;
                                        } else {
                                          isSelectedToggleButton[buttonIndex] = false;
                                        }
                                      }
                                      if (isSelectedToggleButton[0] == true) {
                                        isFoodSelection = true;
                                      } else {
                                        isFoodSelection = false;
                                      }
                                    });
                                  },
                                  isSelected: isSelectedToggleButton,
                                ),
                              ),
                              isFoodSelection ? createNewFood(context): createNewMeetup(context),
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

          if (isFoodSelection) {
            // upload newFood to the database
          } else {
            // is a Meetup named newMeetup that needs to be uploaded to the database
            // DONT FORGET TO ADD currentPlace.name TO THE MEETUP OBJECT THAT IS BEING UPLOADED
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FrameState().build(context),
              ));
        },
      ),
    );
  }

  Widget createNewFood(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            textAlign: TextAlign.left,
            decoration: InputDecoration(
                labelText: 'Food Name',
                border: OutlineInputBorder()),
            maxLength: 30,
            onChanged: (text) {
              foodName = text;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Food Rating')),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Align(
                        alignment: Alignment.center,
                        child: Slider(
                          min: 0.0,
                          max: 5.0,
                          onChanged: (double newRating) {
                            setState(() => foodRating = newRating);
                          },
                          value: foodRating,
                        ),
                      )
                    ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(sprintf("%.1f", [foodRating])),
                    ),
                  )
                ],
              ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            textAlign: TextAlign.left,
            decoration: InputDecoration(
                labelText: 'Food Cost',
                border: OutlineInputBorder()),
            maxLength: 10,
            onChanged: (text) {
              foodCost = text;
            },
          ),
        ),
      ],
    );
  }
  
  Widget createNewMeetup(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            textAlign: TextAlign.left,
            decoration: InputDecoration(
                labelText: 'Meeting Name',
                border: OutlineInputBorder()),
            maxLength: 30,
            onChanged: (text) {
              meetupName = text;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: FlatButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2020, 12, 31), onChanged: (date) {
                    }, onConfirm: (date) {
                      meetupDateTime = date;
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                'Press to pick a date and time',
                style: TextStyle(color: Colors.blue),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            textAlign: TextAlign.left,
            maxLines: 5,
            decoration: InputDecoration(
                labelText: 'Meetup Participants',
                hintText: 'Enter user email addresses seperated by commas. For example: bob@joe.com, john@smith.com',
                border: OutlineInputBorder()),
            onChanged: (text) {
              meetupMembers = text.split(", ");
            },
          ),
        ),
      ],
    );
  }
}