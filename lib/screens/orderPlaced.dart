import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash/screens/mainscreen.dart';

class orderPlaced extends StatefulWidget {
  const orderPlaced({Key? key}) : super(key: key);

  @override
  State<orderPlaced> createState() => _orderPlacedState();
}

class _orderPlacedState extends State<orderPlaced> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C252E),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thanks For Placing Your Order !",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Icon(
              Icons.add_shopping_cart_outlined,
              size: 100,
              color: Theme.of(context).primaryColor,
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
                        MaterialPageRoute(builder: (_) => mainScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 40,
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      const Text(
                        "Back To Home",
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
      ),
    );
  }
}
