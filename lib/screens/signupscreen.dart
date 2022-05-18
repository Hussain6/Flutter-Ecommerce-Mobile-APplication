import 'package:flutter/material.dart';
import 'package:splash/logics/loginSignupfunctions.dart';
import 'package:splash/screens/snackBar.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
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
                "SIGN UP",
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        controller: _username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Color(0xFF8000FF),
                            ),
                            hintText: "Username"),
                      )),
                  SizedBox(
                    height: size.height / 75,
                  ),
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
                  SizedBox(
                    height: size.height / 75,
                  ),
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
                        controller: _password,
                        obscureText: true,
                        obscuringCharacter: "*",
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
                    height: size.height / 70,
                  ),
                  Container(
                    width: size.width / 1.5,
                    height: size.height / 13,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: progress == true
                        ? const Center(
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              setState(() {
                                progress = true;
                              });

                              auth
                                  .firebaseSignUp(
                                      email: _email.text,
                                      password: _password.text,
                                      username: _username.text)
                                  .then((value) {
                                if (value == "Signed Up") {
                                  displaySnackBar(context,
                                      "Account Successfully Created !");
                                } else {
                                  displaySnackBar(context, value);
                                }
                                setState(() {
                                  progress = false;
                                });
                              });
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
                  ),
                  SizedBox(
                    height: size.height / 60,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already Have an Account?",
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
