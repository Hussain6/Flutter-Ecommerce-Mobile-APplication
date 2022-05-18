import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash/logics/loginSignupfunctions.dart';
import 'package:splash/screens/getStartedScreen.dart';
import 'package:splash/screens/loginscreen.dart';
import 'package:splash/screens/previousOrders.dart';
import 'package:splash/screens/snackBar.dart';
import 'package:splash/screens/userProfileInfo.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.username, required this.email})
      : super(key: key);
  String username;
  String email;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Authfunctions _authfunction = Authfunctions();
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
          Container(
            width: size.width / 1,
            height: size.height / 13,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50)),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => userInfoProfile(
                                username: widget.username,
                                email: widget.email,
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_box,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    const Text(
                      "Profile Info",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            width: size.width / 1,
            height: size.height / 13,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50)),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => previousOrders()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    const Text(
                      "Order History",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            width: size.width / 1,
            height: size.height / 13,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(50)),
            child: TextButton(
                onPressed: () async {
                  await _authfunction.firebaseSignOut().then((value) => {
                        if (value == "Signed Out")
                          displaySnackBar(context, "Signed Out !")
                        else
                          {displaySnackBar(context, value)}
                      });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => loginscreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    const Text(
                      "Sign Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }
}
