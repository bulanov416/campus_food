import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static FirebaseUser user;

  static Future<FirebaseUser> refreshFirebaseUser() async {
    user = await FirebaseAuth.instance.currentUser();
    return user;
  }
}