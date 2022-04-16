import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  int? accountId;
  String? email;
  String? name;
  bool? gender;
  String? dateOfBirth;
  String? address;
  String? phone;
  String? avatarUrl;
  String? roleId;
  String? sectionId;
  bool? isActive;

  Account(
      {this.accountId,
      this.email,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.address,
      this.phone,
      this.avatarUrl,
      this.roleId,
      this.sectionId,
      this.isActive});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  Map<String, String> toJson2() => <String, String>{
      'AccountId': accountId.toString(),
      'Email': email.toString(),
      'Name': name.toString(),
      'Gender': gender.toString(),
      'DateOfBirth': dateOfBirth!.toString(),
      //'Address': address!.toString(),
      'Phone': phone.toString(),
      'AvatarUrl': avatarUrl.toString(),
      'RoleId': roleId.toString(),
      //'SectionId': sectionId!.toString(),
      'IsActive': isActive.toString(),
    };
}
