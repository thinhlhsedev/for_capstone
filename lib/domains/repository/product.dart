import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String? productId;
  String? productName;
  int? amount;
  double? price;
  String? imageUrl;
  String? status;
  String? description;

  Product(
      {this.productId,
      this.productName,
      this.amount,
      this.price,
      this.imageUrl,
      this.status,
      this.description});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return productId! + price.toString();
  }
}

List<Product> demoProduct = [
    Product(
      productId: "df",
      productName: "Bếp gas 1",
      price: 34
    ),
    Product(
      productId: "fgfg",
      productName: "Bếp gas 2",
      price: 56
    ),
    Product(
      productId: "dfgas",
      productName: "Bếp gas 3",
      price: 32
    ),    
  ];