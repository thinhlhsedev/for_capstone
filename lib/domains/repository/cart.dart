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
    var list = jsonDecode(json['cartInfo'].replaceAll("\\", ""));
    if (list.length != 0) {
      list.forEach((v) {
        cartInfo!.add(CartProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartId'] = cartId;
    if (cartInfo != null) {
      data['cartInfo'] = cartInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, String> toJson2() {
    final Map<String, String> data = <String, String>{};
    data['cartId'] = cartId.toString();
    if (cartInfo != null) {
      data['cartInfo'] = cartInfo!.map((v) => v.toJson()).toList().toString();
    }
    return data;
  }
}
