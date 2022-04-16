import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? orderId;
  int? accountId;
  double? totalPrice;
  String? expiryDate;
  String? status;
  String? note;
  bool? isShorTerm;
  String? customerAddress;

  Order(
      {this.orderId,
      this.accountId,
      this.totalPrice,
      this.expiryDate,
      this.status,
      this.note,
      this.isShorTerm,
      this.customerAddress});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
