import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  //late final UserCredential userid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> addtoCart(
      String productImage, String productName, String productPrice) async {
    try {
      await _firebaseFirestore
          .collection("Cart")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("Orders")
          .doc(productName)
          .set({
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice
      });
      return "Product Added to Cart";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> deletefromCart(String productName) async {
    try {
      await _firebaseFirestore
          .collection("Cart")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection("Orders")
          .doc(productName)
          .delete();
      return "Product Deleted from Cart";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
