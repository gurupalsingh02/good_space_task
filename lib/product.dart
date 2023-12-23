// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String displayName;
  final String productName;

  Product({
    required this.displayName,
    required this.productName,
  });

  Product copyWith({
    String? displayName,
    String? productName,
  }) {
    return Product(
      displayName: displayName ?? this.displayName,
      productName: productName ?? this.productName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'productName': productName,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      displayName: map['displayName'] as String,
      productName: map['productName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(Map<String, dynamic> source) =>
      Product.fromMap(source);
}
