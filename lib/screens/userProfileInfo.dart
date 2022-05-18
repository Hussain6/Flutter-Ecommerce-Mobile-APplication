import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash/logics/fetchUserInfo.dart';
import 'package:splash/screens/user.dart';

class userInfoProfile extends StatefulWidget {
  userInfoProfile({Key? key, required this.username, required this.email})
      : super(key: key);
  String username;
  String email;
  @override
  State<userInfoProfile> createState() => _userInfoProfileState();
}

@override
class _userInfoProfileState extends State<userInfoProfile> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF1C252E),
      body: Column(
        children: [
          Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 400,
          ),
          UserInfoWidget(context, size, widget.username, "Username"),
          UserInfoWidget(context, size, widget.email, "Email"),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            width: size.width / 1.1,
            height: size.height / 13,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50)),
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Back",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    ));
  }
}

Widget UserInfoWidget(
    BuildContext context, Size size, String _userData, String label) {
  return Container(
    margin: const EdgeInsets.all(7),
    height: size.height * 0.09,
    width: size.width * 1,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF324251)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(label + " : " + _userData,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
