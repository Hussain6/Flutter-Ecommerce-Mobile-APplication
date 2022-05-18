import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authfunctions {
  late final UserCredential userid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> firebaseSignIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> firebaseSignUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      userid = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firebaseFirestore
          .collection("usersData")
          .doc(userid.user!.uid)
          .set({"Username": username, "Email": email, "Password": password});
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> firebaseSignOut() async {
    try {
      _firebaseAuth.signOut();
      return "Signed Out";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
