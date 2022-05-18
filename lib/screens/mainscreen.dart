// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:intl/intl.dart';
import 'package:splash/logics/fetchUserInfo.dart';
import 'package:splash/screens/allProductScreen.dart';
import 'package:splash/screens/cartScreen.dart';
import 'package:splash/screens/user.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String formatter = DateFormat.yMMMMd('en_US').format(DateTime.now());
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C252E),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width / 18,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: _firebaseFirestore
                          .collection("usersData")
                          .doc(_auth.currentUser?.uid)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return const Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          userInfo.Email = data["Email"];
                          userInfo.Username = data["Username"];
                          return Text(
                            "Hey " + data["Username"],
                            style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          );
                        }

                        return const CircularProgressIndicator();
                      },
                    ),
                    SizedBox(
                      width: size.width / 2.4,
                    ),
                    SizedBox(
                      width: size.width / 60,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: InkWell(
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => cartProducts()));
                        },
                      ),
                    ),
                    SizedBox(
                      width: size.width / 60,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProfileScreen(
                                    email: userInfo.Email,
                                    username: userInfo.Username)));
                      },
                      child: const CircleAvatar(
                        child: Icon(Icons.account_circle),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 90,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 10,
                  ),
                  Text(formatter,
                      style: const TextStyle(
                          color: Color(0xFF858C93),
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ],
              ),
              SizedBox(
                height: size.height / 60,
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/sale.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 10,
                  ),
                  const Text("Browse Categories",
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ],
              ),
              SizedBox(
                height: size.height / 60,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductScreen(
                                    productCategory: "MobilePhones")));
                      },
                      child: categoriesWidget(
                          size, "Mobiles", Icons.phone_iphone_rounded),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductScreen(
                                      productCategory: "Electronics")));
                        },
                        child: categoriesWidget(
                            size, "Electronics", Icons.computer)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductScreen(
                                      productCategory: "Fashion")));
                        },
                        child: categoriesWidget(
                            size, "Fashion", Icons.shopping_bag)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductScreen(
                                      productCategory: "Sports")));
                        },
                        child: categoriesWidget(
                            size, "Sports", Icons.sports_cricket)),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 10,
                  ),
                  const Text("On Going",
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ],
              ),
              SizedBox(
                height: size.height / 60,
              ),
              onGoingWidget(context, size, "LimeLight is Offering ",
                  "Flat 60% OFF", "29 Feb - 30 April", "assets/limelight.png"),
              onGoingWidget(context, size, "Sapphire is Offering ",
                  "Flat 40% OFF", "29 Feb - 25 July", "assets/sapphire.png"),
              onGoingWidget(context, size, "Addidas is Offering ",
                  "Upto 30% OFF", "29 Feb - 15 ", "assets/addidas.png"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget onGoingWidget(BuildContext context, Size size, String text1,
    String text2, String text3, String imagePath) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ProductScreen(productCategory: "Fashion")));
    },
    child: Container(
        margin: const EdgeInsets.all(7),
        height: size.height / 5,
        width: size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFF373E48)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: size.height / 12,
                      width: size.width / 15,
                    ),
                    Text(text1,
                        style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      //   height: size.height / 80,
                      width: size.width / 15,
                    ),
                    Text(text2,
                        style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                      width: size.width / 15,
                    ),
                    const CircleAvatar(
                      radius: 8,
                      backgroundColor: Color(
                        0xFFDB6D7B,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                      width: size.width / 35,
                    ),
                    Text(text3,
                        style: const TextStyle(
                            color: Color(0xFF898E95),
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: size.height / 5,
                  width: size.width / 4.5,
                  child: Image.asset(
                    imagePath,
                  ),
                )
              ],
            )
          ]),
        )),
  );
}

Widget categoriesWidget(Size size, String text, IconData iconn) {
  return InkWell(
    child: Container(
      margin: const EdgeInsets.all(7),
      height: size.height / 4.5,
      width: size.width / 3.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFE8D79),
              Color(0xFFFF5276),
              Colors.purple,

              // Colors.blue
            ],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconn,
            size: 90,
            color: Colors.black,
          ),
          Text(text,
              style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 18))
        ],
      ),
    ),
  );
}
