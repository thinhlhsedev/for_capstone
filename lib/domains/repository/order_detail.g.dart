// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => OrderDetail(
      orderDetailId: json['orderDetailId'] as int?,
      orderId: json['orderId'] as int?,
      productId: json['productId'] as String?,
      amount: json['amount'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      note: json['note'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'orderDetailId': instance.orderDetailId,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'amount': instance.amount,
      'price': instance.price,
      'note': instance.note,
      'product': instance.product,
    };
