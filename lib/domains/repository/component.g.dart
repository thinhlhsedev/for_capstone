// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Component _$ComponentFromJson(Map<String, dynamic> json) => Component(
      componentId: json['componentId'] as String?,
      componentName: json['componentName'] as String?,
      amount: json['amount'] as int?,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as String?,
      substance: json['substance'] as String?,
      size: json['size'] as String?,
      color: json['color'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'componentId': instance.componentId,
      'componentName': instance.componentName,
      'amount': instance.amount,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'substance': instance.substance,
      'size': instance.size,
      'color': instance.color,
      'weight': instance.weight,
      'description': instance.description,
    };
