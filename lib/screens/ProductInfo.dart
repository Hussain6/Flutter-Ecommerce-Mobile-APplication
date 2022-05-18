import 'package:flutter/material.dart';
import 'package:splash/logics/cartFunctions.dart';
import 'package:splash/screens/snackBar.dart';

class productInfo extends StatefulWidget {
  productInfo(
      {Key? key,
      required this.productName,
      required this.productImage,
      required this.productDescription,
      required this.productPrice,
      required this.productRating})
      : super(key: key);
  String productImage;
  String productName;
  String productDescription;
  String productRating;
  String productPrice;
  @override
  _productInfoState createState() => _productInfoState();
}

class _productInfoState extends State<productInfo> {
  @override
  Widget build(BuildContext context) {
    Cart c = Cart();
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF242323),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height / 2.5,
                width: size.width / 1.3,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.network(widget.productImage),
              ),
              Container(
                height: size.height / 1.8,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Color(0xFF1E386A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(1000.0),
                      topRight: Radius.circular(1000.0),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 15,
                    ),
                    Text(
                      widget.productName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Text("\$" + widget.productPrice,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.redAccent)),
                    SizedBox(
                      height: size.height / 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(widget.productDescription,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white)),
                    ),
                    Center(
                      child: Container(
                        width: size.width / 1.1,
                        height: size.height / 13,
                        decoration: BoxDecoration(
                            color: const Color(0xFFC4C4C4),
                            borderRadius: BorderRadius.circular(50)),
                        child: TextButton(
                            onPressed: () {
                              c
                                  .addtoCart(widget.productImage,
                                      widget.productName, widget.productPrice)
                                  .then((value) {
                                if (value == "Signed Up") {
                                  displaySnackBar(context,
                                      "Account Successfully Created !");
                                } else {
                                  displaySnackBar(context, value);
                                }
                              });
                            },
                            child: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
