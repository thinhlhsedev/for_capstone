// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      amount: json['amount'] as int?,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      status: json['status'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'amount': instance.amount,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'description': instance.description,
    };
