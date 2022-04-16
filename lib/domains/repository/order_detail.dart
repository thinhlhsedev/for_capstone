import 'package:for_capstone/domains/repository/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_detail.g.dart';

@JsonSerializable()
class OrderDetail {
  int? orderDetailId;
  int? orderId;
  String? productId;
  int? amount;
  double? price;
  String? note;
  Product? product;

  OrderDetail(
      {this.orderDetailId,
      this.orderId,
      this.productId,
      this.amount,
      this.price,
      this.note,
      this.product
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}