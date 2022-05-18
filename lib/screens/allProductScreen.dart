import 'package:flutter/material.dart';
import 'package:splash/logics/productInfoClass.dart';
import 'package:splash/screens/ProductInfo.dart';
import 'package:splash/screens/mainscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.productCategory}) : super(key: key);
  String productCategory;
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    product productInfo = product(
        productImage: "",
        productName: "",
        productDescription: "",
        productRating: "",
        productPrice: "");
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width / 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFE4E7E7),
                            // color: Color(0xFFF8F9F9),
                            borderRadius: BorderRadius.circular(20)),
                        width: size.width / 1.35,
                        height: size.height / 18,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2, right: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: TextStyle(color: Color(0xFFA6A6A8))),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 17,
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream:
                      _firestore.collection(widget.productCategory).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: size.width / 2,
                                  mainAxisExtent: size.height / 3),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            productInfo.productDescription = snapshot.data!.docs
                                .elementAt(index)
                                .get("productDescription");
                            productInfo.productImage = snapshot.data!.docs
                                .elementAt(index)
                                .get("productImage");
                            productInfo.productName = snapshot.data!.docs
                                .elementAt(index)
                                .get("productName");
                            productInfo.productRating = snapshot.data!.docs
                                .elementAt(index)
                                .get("productRating");
                            productInfo.productPrice = snapshot.data!.docs
                                .elementAt(index)
                                .get("productPrice");
                            return categoriesWidget(
                                context,
                                size,
                                productInfo.productImage,
                                productInfo.productName,
                                productInfo.productPrice,
                                productInfo.productRating,
                                productInfo.productDescription);
                          });
                    }
                    return const Text("ok");
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Widget categoriesWidget(BuildContext context, Size size, String _image,
    String name, String price, String rating, String description) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => productInfo(
                    productImage: _image,
                    productName: name,
                    productPrice: price,
                    productRating: rating,
                    productDescription: description,
                  )));
    },
    child: Container(
      margin: const EdgeInsets.all(7),
      height: size.height / 4.5,
      width: size.width / 3.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // gradient: const LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [
          //     Color(0xFFFE8D79),
          //     Color(0xFFFF5276),
          //     Colors.purple,

          //     // Colors.blue
          //   ],
          // )
          color: const Color(0xFF324251)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: size.height / 5,
            width: size.width / 2.5,
            color: Colors.transparent,
            child: Center(
              child: Image.network(
                _image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: size.width / 25,
              ),
              Text(name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("\$" + price,
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(" " + rating,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
