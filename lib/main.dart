import 'package:campus_food/frame.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Eats',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Frame(pageTitle: 'Food Friend',),
    );
  }
}