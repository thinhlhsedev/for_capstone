import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String productId;
  String productName;
  int? amount;
  double price;
  String imageUrl;
  String? status;
  String? description;

  Product(
      {required this.productId,
      required this.productName,
      this.amount,
      required this.price,
      required this.imageUrl,
      this.status,
      this.description});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}