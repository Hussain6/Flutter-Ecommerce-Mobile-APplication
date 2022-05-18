import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splash/screens/orderPlaced.dart';
import 'package:splash/screens/snackBar.dart';

class payNow extends StatefulWidget {
  const payNow({Key? key}) : super(key: key);

  @override
  State<payNow> createState() => _payNowState();
}

class _payNowState extends State<payNow> {
  TextEditingController _cardNo = TextEditingController();

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
            SizedBox(
              height: size.height * 0.025,
            ),
            Text(
              "Pay Now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
                width: size.width / 1.1,
                height: size.height / 15,
                // margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFEAE7EC)),
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  keyboardType: TextInputType.number,
                  controller: _cardNo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.credit_card,
                        color: Color(0xFF8000FF),
                      ),
                      hintText: "Credit Card No."),
                )),
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
                  onPressed: () async {
                    if (_cardNo.text != "" && _cardNo.text.length == 16) {
                      try {
                        var collection = FirebaseFirestore.instance
                            .collection('Cart')
                            .doc(_auth.currentUser!.uid)
                            .collection("Orders");
                        var snapshots = await collection.get();
                        for (var doc in snapshots.docs) {
                          var OrderData = await doc.reference.get();
                          var del = await doc.reference.delete();
                          await _firestore
                              .collection("Cart")
                              .doc(_auth.currentUser!.uid)
                              .collection("PreviousOrders")
                              .doc(OrderData["productName"])
                              .set({
                            "productImage": OrderData["productImage"],
                            "productName": OrderData["productName"],
                            "productPrice": OrderData["productPrice"]
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => orderPlaced()));
                    } else {
                      displaySnackBar(
                          context, "Error : Enter Valid Credit Card No");
                    }
                  },
                  child: const Text(
                    "Place Order",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
