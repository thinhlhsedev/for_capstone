import 'dart:convert';

import 'cartproduct.dart';

class Cart {
  int? accountId;
  int? cartId;
  double? totalPrice;
  List<CartProduct>? cartInfo;

  Cart({
    this.cartId,
    this.accountId,
    this.totalPrice,
    this.cartInfo,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    accountId = json['accountId'];
    totalPrice = json['totalPrice'];
    cartInfo = <CartProduct>[];
    if (json['cartInfo'] != null) {
      var list = jsonDecode(json['cartInfo'].replaceAll("\\", ""));
      if (list.length != 0) {
        list.forEach((v) {
          cartInfo!.add(CartProduct.fromJson(v));
        });
      }
    } else {
      cartInfo = <CartProduct>[];
    }
  }

  Cart.fromJson2(Map<String, dynamic> json) {
    cartId = json['cartId'];
    accountId = json['accountId'];
    totalPrice = json['totalPrice'];
    cartInfo = (json['cartInfo']);
  }

  Cart.fromJson3(Map<String, dynamic> json) {
    cartId = json['cartId'];
    accountId = json['accountId'];
    totalPrice = json['totalPrice'];
    cartInfo = <CartProduct>[];
    var list = json['cartInfo'];
    if (list == null) {
      list = <CartProduct>[];
    } else if (list.length != 0) {
      list.forEach((v) {
        cartInfo!.add(CartProduct.fromJson(v));
      });
    }
  }

  get list => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartId'] = cartId;
    data['accountId'] = accountId;
    data['totalPrice'] = totalPrice;
    if (cartInfo != null) {
      data['cartInfo'] = cartInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, String> toJson2() {
    final Map<String, String> data = <String, String>{};
    data['CartId'] = cartId.toString();
    data['AccountId'] = accountId.toString();
    data['TotalPrice'] = totalPrice.toString();
    if (cartInfo != null) {
      data['CartInfo'] = cartInfo!.map((v) => v.toJson()).toList().toString();
    }
    return data;
  }

  Map<String, dynamic> toJson3() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CartId'] = cartId;
    data['AccountId'] = accountId;
    data['TotalPrice'] = totalPrice;
    if (cartInfo != null) {
      var str = cartInfo!.map((v) => v.toJson()).toList();
      data['CartInfo'] = jsonEncode(str);
    }
    return data;
  }
}
