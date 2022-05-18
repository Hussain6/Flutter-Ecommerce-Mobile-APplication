import 'package:flutter/material.dart';
import 'package:splash/screens/paymentMethod.dart';
import 'package:splash/screens/snackBar.dart';

class checkOut extends StatefulWidget {
  const checkOut({Key? key, required this.TotalAmmount}) : super(key: key);
  final String TotalAmmount;
  @override
  State<checkOut> createState() => _checkOutState();
}

class _checkOutState extends State<checkOut> {
  TextEditingController _location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                "Checkout",
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
                    controller: _location,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.location_history,
                          color: Color(0xFF8000FF),
                        ),
                        hintText: "Location"),
                  )),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Amount : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$" + widget.TotalAmmount,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
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
                      if (_location.text != "") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => paymentMethod()));
                      } else {
                        displaySnackBar(context, "Error : Enter Location");
                      }
                    },
                    child: const Text(
                      "Set Payment Method",
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
