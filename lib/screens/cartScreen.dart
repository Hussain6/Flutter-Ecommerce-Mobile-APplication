import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:splash/logics/cartFunctions.dart';
import 'package:splash/screens/Checkout.dart';

class cartProducts extends StatefulWidget {
  cartProducts({Key? key}) : super(key: key);

  @override
  State<cartProducts> createState() => _cartProductsState();
}

class _cartProductsState extends State<cartProducts> {
  @override
  static int TotalAmount = 0;
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C252E),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 30,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    "My Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: size.height * 0.05,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("Cart")
                      .doc(_auth.currentUser!.uid)
                      .collection("Orders")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      TotalAmount = 0;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // gridDelegate:
                          //     SliverGridDelegateWithMaxCrossAxisExtent(
                          //         maxCrossAxisExtent: size.width / 2,
                          //         mainAxisExtent: size.height / 3),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String productImage = snapshot.data!.docs
                                .elementAt(index)
                                .get("productImage");
                            String productName = snapshot.data!.docs
                                .elementAt(index)
                                .get("productName");
                            String productPrice = snapshot.data!.docs
                                .elementAt(index)
                                .get("productPrice");
                            TotalAmount = TotalAmount + int.parse(productPrice);
                            return categoriesWidget(context, size, productImage,
                                productName, productPrice);
                          });
                    }
                    return const Text("ok");
                  }),
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                width: size.width * 0.95,
                height: size.height / 13,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => checkOut(TotalAmmount: TotalAmount.toString(),)));
                    },
                    child: const Text(
                      "Proceed to Check Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget categoriesWidget(
    BuildContext context, Size size, String _image, String name, String price) {
  Cart c = Cart();
  return Container(
    margin: const EdgeInsets.all(7),
    height: size.height * 0.15,
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
                Container(
                  height: size.height * 0.1,
                  width: size.width * 0.2,
                  color: Colors.transparent,
                  child: Center(
                    child: Image.network(
                      _image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                Text("\$" + price,
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                InkWell(
                    onTap: () async {
                      await c.deletefromCart(name);
                    },
                    child: Icon(Icons.delete))
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
