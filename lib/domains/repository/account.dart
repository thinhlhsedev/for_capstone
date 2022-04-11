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

  Account.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    phone = json['phone'];
    avatarUrl = json['avatarUrl'];
    roleId = json['roleId'];
    sectionId = json['sectionId'];
    isActive = json['isActive'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['accountId'] = accountId.toString();
    data['email'] = email.toString();
    data['name'] = name.toString();
    data['gender'] = gender.toString();
    data['dateOfBirth'] = dateOfBirth.toString();
    data['address'] = address.toString();
    data['phone'] = phone.toString();
    data['avatarUrl'] = avatarUrl.toString();
    data['roleId'] = roleId.toString();
    data['sectionId'] = sectionId.toString();
    data['isActive'] = isActive.toString();
    return data;
  }
}
