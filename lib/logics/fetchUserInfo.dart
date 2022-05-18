import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class userInfo {
  static late String Username;
  static late String Email;

  void setterUserInfo(String user, String email) {
    Email = email;
    Username = user;
  }
}
