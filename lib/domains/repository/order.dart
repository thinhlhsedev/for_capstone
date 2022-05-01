import 'package:json_annotation/json_annotation.dart';

import 'order_detail.dart';

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
  String? customerName;
  String? customerAddress;
  List<OrderDetail>? orderDetails;

  Order(
      {this.orderId,
      this.accountId,
      this.totalPrice,
      this.expiryDate,
      this.status,
      this.note,
      this.isShorTerm,
      this.customerAddress,
      this.customerName,
      this.orderDetails});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this); 

  Map<String, dynamic> toJson2() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['orderId'] = orderId;
    data['accountId'] = accountId;
    data['totalPrice'] = totalPrice;
    data['expiryDate'] = expiryDate;
    data['status'] = status;
    data['note'] = note;
    data['isShorTerm'] = isShorTerm;
    data['customerName'] = customerName;
    data['customerAddress'] = customerAddress;
    if (orderDetails != null) {
      data['orderDetail'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
