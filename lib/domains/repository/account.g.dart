// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      accountId: json['accountId'] as int?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as bool?,
      dateOfBirth: json['dateOfBirth'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      roleId: json['roleId'] as String?,
      sectionId: json['sectionId'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'accountId': instance.accountId,
      'email': instance.email,
      'name': instance.name,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'address': instance.address,
      'phone': instance.phone,
      'avatarUrl': instance.avatarUrl,
      'roleId': instance.roleId,
      'sectionId': instance.sectionId,
      'isActive': instance.isActive,
    };
