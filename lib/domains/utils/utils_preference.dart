import 'dart:convert';
import 'package:for_capstone/domains/repository/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/account.dart';
import '../repository/cartproduct.dart';

class UtilsPreference {
  static late SharedPreferences _preferences;

  static const _keyAccountId = "id";
  static const _keyEmail = "email";
  static const _keyPhoto = "photo";
  static const _keyDisplayName = "name";
  static const _keyPhone = "phone";
  static const _keyDOB = "dob";
  static const _keyGender = "gender";
  static const _keyAccount = "account";

  static const _keyCartId = "cartId";
  static const _keyTotalPrice = "0";
  static const _keyCartInfo = "cartInfo";
  static const _keyCart = "cart";

  //Initiation
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  //Display name
  static Future setAccountId(String accountId) async =>
      await _preferences.setString(_keyAccountId, accountId);

  static String? getAccountId() => _preferences.getString(_keyAccountId);

  //Display name
  static Future setDisplayName(String displayName) async =>
      await _preferences.setString(_keyDisplayName, displayName);

  static String? getDisplayname() => _preferences.getString(_keyDisplayName);

  //Email
  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static String? getEmail() => _preferences.getString(_keyEmail);

  //Photo url
  static Future setPhoto(String photoUrl) async =>
      await _preferences.setString(_keyPhoto, photoUrl);

  static String? getPhoto() => _preferences.getString(_keyPhoto);

  //DOB
  static Future setDOB(String dob) async =>
      await _preferences.setString(_keyDOB, dob);

  static String? getDOB() => _preferences.getString(_keyDOB);

  //Gender
  static Future setGender(String gender) async =>
      await _preferences.setString(_keyGender, gender);

  static String? getGender() => _preferences.getString(_keyGender);

  //Phone
  static Future setPhone(String gender) async =>
      await _preferences.setString(_keyPhone, gender);

  static String? getPhone() => _preferences.getString(_keyPhone);

  //Account
  static Future setFullAccount(Account account) async =>
      await _preferences.setString(_keyAccount, jsonEncode(account));

  static String? getFullAccount() => _preferences.getString(_keyAccount);

  //Set full
  static Future setAccount(Account account) async {
    await setAccountId(account.accountId.toString());
    await setDisplayName(account.name ?? "user" + account.accountId.toString());
    await setPhone(account.phone ?? "");
    await setDOB(account.dateOfBirth ?? "");
    await setGender(account.gender.toString());
    await setEmail(account.email ?? "");
    await setFullAccount(account);
  }

  //===========================================================================//

  //Cart Id
  static Future setCartId(int cartId) async =>
      await _preferences.setInt(_keyCartId, cartId);

  static String? getCartId() => _preferences.getString(_keyCartId);

  //Total Price
  static Future setTotalPrice(double totalPrice) async =>
      await _preferences.setDouble(_keyTotalPrice, totalPrice);

  static double? getTotalPrice() => _preferences.getDouble(_keyTotalPrice);

  //List Item
  static Future setCartInfo(List<CartProduct> cartInfo) async {
    await _preferences.setString(_keyCartInfo, jsonEncode(cartInfo));
  }

  static String? getCartInfo() => _preferences.getString(_keyCartInfo);

  //Cart
  static Future setFullCart(Cart cart) async {
    await _preferences.setString(_keyCart, jsonEncode(cart));
  }

  static String? getFullCart() => _preferences.getString(_keyCart);

  //Set full
  static Future setCart(Cart cart) async {
    await setCartId(cart.cartId ?? 0);
    await setTotalPrice(cart.totalPrice ?? 0);
    await setCartInfo(cart.cartInfo!);
    await setFullCart(cart);
  }
}
