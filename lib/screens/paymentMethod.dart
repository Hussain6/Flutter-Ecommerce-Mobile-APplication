import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash/screens/orderPlaced.dart';
import 'package:splash/screens/payNow.dart';

class paymentMethod extends StatefulWidget {
  const paymentMethod({Key? key}) : super(key: key);

  @override
  State<paymentMethod> createState() => _paymentMethodState();
}

class _paymentMethodState extends State<paymentMethod> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C252E),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.025,
              ),
              Text(
                "Payment Method",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
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
                    onPressed: () async {
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
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.black,
                          size: 40,
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        const Text(
                          "Cash On Delivery",
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
                    onPressed: () async {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => payNow()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: Colors.black,
                          size: 40,
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        const Text(
                          "Pay Now",
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
      ),
    );
  }
}
