import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './settings_view.dart';

class Auth {
  static FirebaseUser user;

  static Future<FirebaseUser> refreshFirebaseUser() async {
    user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  static void SignInAlert(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Sign in required"),
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Sign in"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => (SettingsView()),
                  )
                );
              }
            ),
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
  }

}