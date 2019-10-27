import 'package:campus_food/frame.dart';
import 'package:flutter/material.dart';
import './auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Auth.refreshFirebaseUser();
    return MaterialApp(
      title: 'Food Friend',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: const Color(0xFFffffff)
      ),
      home: Frame(pageTitle: 'Food Friend',),
    );
  }
}
