import 'package:shared_preferences/shared_preferences.dart';

import '../repository/account.dart';

class AccountPreference {
  static SharedPreferences? _preferences;

  static const _keyEmail = "email";
  static const _keyPhoto = "photo";
  static const _keyDisplayName = "name";
  static const _keyPhone = "phone";
  static const _keyDOB = "dob";
  static const _keyGender = "gender";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  //Display name
  static Future setDisplayName(String displayName) async =>
      await _preferences!.setString(_keyDisplayName, displayName);

  static String? getDisplayname() => _preferences!.getString(_keyDisplayName);

  //Email
  static Future setEmail(String email) async =>
      await _preferences!.setString(_keyEmail, email);

  static String? getEmail() => _preferences!.getString(_keyEmail);

  //Photo url
  static Future setPhoto(String photoUrl) async =>
      await _preferences!.setString(_keyPhoto, photoUrl);

  static String? getPhoto() => _preferences!.getString(_keyPhoto);

  //DOB
  static Future setDOB(String dob) async =>
      await _preferences!.setString(_keyDOB, dob);

  static String? getDOB() => _preferences!.getString(_keyDOB);

  //Gender
  static Future setGender(String gender) async =>
      await _preferences!.setString(_keyGender, gender);

  static String? getGender() => _preferences!.getString(_keyGender);

  //Phone
  static Future setPhone(String gender) async =>
      await _preferences!.setString(_keyPhone, gender);

  static String? getPhone() => _preferences!.getString(_keyPhone);

  static Future setAccount(Account account) async {
    await _preferences!.setString(
        _keyDisplayName, account.name ?? "user" + account.accountId.toString());
    await _preferences!.setString(_keyPhone, account.phone ?? "");
    await _preferences!.setString(_keyDOB, account.dateOfBirth ?? "");
    await _preferences!.setString(_keyGender, account.gender.toString());
    await _preferences!.setString(_keyPhoto, account.avatarUrl ?? _keyPhoto);    
  }
}
