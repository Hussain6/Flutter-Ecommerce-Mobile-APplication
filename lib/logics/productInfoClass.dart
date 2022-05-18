import 'dart:convert';


class product {
   String productImage = "";
   String productName = "";
   String productDescription = "";
   String productRating = "";
   String productPrice = "";
  product({
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.productRating,
    required this.productPrice,
  });


  product copyWith({
    String? productImage,
    String? productName,
    String? productDescription,
    String? productRating,
    String? productPrice,
  }) {
    return product(
      productImage: productImage ?? this.productImage,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productRating: productRating ?? this.productRating,
      productPrice: productPrice ?? this.productPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productImage': productImage,
      'productName': productName,
      'productDescription': productDescription,
      'productRating': productRating,
      'productPrice': productPrice,
    };
  }

  factory product.fromMap(Map<String, dynamic> map) {
    return product(
      productImage: map['productImage'] ?? '',
      productName: map['productName'] ?? '',
      productDescription: map['productDescription'] ?? '',
      productRating: map['productRating'] ?? '',
      productPrice: map['productPrice'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory product.fromJson(String source) => product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'product(productImage: $productImage, productName: $productName, productDescription: $productDescription, productRating: $productRating, productPrice: $productPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is product &&
      other.productImage == productImage &&
      other.productName == productName &&
      other.productDescription == productDescription &&
      other.productRating == productRating &&
      other.productPrice == productPrice;
  }

  @override
  int get hashCode {
    return productImage.hashCode ^
      productName.hashCode ^
      productDescription.hashCode ^
      productRating.hashCode ^
      productPrice.hashCode;
  }
}
