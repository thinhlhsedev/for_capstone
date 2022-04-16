// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      orderId: json['orderId'] as int?,
      accountId: json['accountId'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      expiryDate: json['expiryDate'] as String?,
      status: json['status'] as String?,
      note: json['note'] as String?,
      isShorTerm: json['isShorTerm'] as bool?,
      customerAddress: json['customerAddress'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'accountId': instance.accountId,
      'totalPrice': instance.totalPrice,
      'expiryDate': instance.expiryDate,
      'status': instance.status,
      'note': instance.note,
      'isShorTerm': instance.isShorTerm,
      'customerAddress': instance.customerAddress,
    };
