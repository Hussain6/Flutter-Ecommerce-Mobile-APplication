import 'package:flutter/material.dart';
import 'package:splash/logics/loginSignupfunctions.dart';
import 'package:splash/screens/mainscreen.dart';
import 'package:splash/screens/signupscreen.dart';
import 'package:splash/screens/snackBar.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final formKey = GlobalKey<FormState>();
    final Authfunctions auth = Authfunctions();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height / 50,
              ),
              const Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Center(
                child: Image.asset(
                  "assets/login.png",
                  height: size.height / 2,
                  width: size.width / 1.1,
                ),
              ),
              Form(
                  // key: formKey,
                  child: Column(
                children: [
                  Container(
                      width: size.width / 1.1,
                      height: size.height / 15,
                      // margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFEAE7EC)),
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value!.length < 10 || value.isEmpty) {
                        //     return "Invalid Email";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        controller: _email,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email_rounded,
                              color: Color(0xFF8000FF),
                            ),
                            hintText: "Email"),
                      )),
                  Container(
                      width: size.width / 1.1,
                      height: size.height / 15,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFEAE7EC)),
                      child: TextFormField(
                        controller: _password,
                        obscuringCharacter: "•",
                        obscureText: true,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Color(0xFF8000FF),
                            ),
                            hintText: "Password"),
                      )),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Center(
                    child: Container(
                      width: size.width / 1.5,
                      height: size.height / 13,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: progress == true
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                setState(() {
                                  progress = true;
                                });
                                auth
                                    .firebaseSignIn(
                                        email: _email.text,
                                        password: _password.text)
                                    .then((value) {
                                  progress = false;
                                  if (value == "Signed In") {
                                    displaySnackBar(
                                        context, "Signed In Successfully !");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => mainScreen()));
                                  } else {
                                    displaySnackBar(context, value);
                                  }
                                  setState(() {
                                    progress = false;
                                  });
                                });
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const signup()));
                    },
                    child: const Text(
                      "Don't Have an Account?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
