import 'package:json_annotation/json_annotation.dart';

part 'cartproduct.g.dart';

@JsonSerializable()
class CartProduct {
  String? productId;
  int? amount;

  CartProduct({this.productId, this.amount});

  factory CartProduct.fromJson(Map<String, dynamic> json) => _$CartProductFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}