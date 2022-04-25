import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:for_capstone/domains/repository/cartproduct.dart';
import 'package:for_capstone/domains/utils/utils_preference.dart';
import 'package:for_capstone/size_config.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/cart.dart';
import '../../../domains/repository/product.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.product,
    required this.number,
  }) : super(key: key);

  final Product product;
  final int number;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      height: SizeConfig.screenHeight * 0.07,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  primary: kPrimaryColor,
                ),
                onPressed: () {
                  if (number != 0) {
                    try {
                      CartProduct cartProduct = CartProduct(
                          productId: product.productId, amount: number);
                      List<CartProduct> cartInfo = [];
                      var list = jsonDecode(UtilsPreference.getCartInfo()!);
                      totalPrice = UtilsPreference.getTotalPrice()!;

                      checkCart(list, cartProduct, cartInfo, totalPrice);

                      Cart cart = setCart(cartInfo, totalPrice);

                      updateCart("updateCart", cart);

                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar("Đã thêm vào giỏ hàng"),
                      );
                    } on Exception {
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildSnackBar("Có lỗi với giỏ hàng"),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(buildSnackBar("Vui lòng tăng số lượng"));
                  }
                },
                child: Text(
                  "Thêm vào giỏ hàng".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Cart setCart(List<CartProduct> cartInfo, double totalPrice) {
    var cart = Cart.fromJson3(jsonDecode(UtilsPreference.getFullCart()!));
    cart.cartInfo = cartInfo;
    cart.totalPrice = totalPrice;
    UtilsPreference.setFullCart(cart);
    return cart;
  }

  void checkCart(list, CartProduct cartProduct, List<CartProduct> cartInfo,
      double totalPrice) async {
    list.forEach((v) async {
      var productTmp = CartProduct.fromJson(v);
      cartInfo.add(productTmp);
    });

    var len = cartInfo.length;
    bool checkExist = false;

    for (int i = 0; i < len; i++) {
      if (cartInfo[i].productId == cartProduct.productId) {
        cartInfo[i].amount = cartInfo[i].amount! + cartProduct.amount!;
        totalPrice = await getPrice(cartProduct, totalPrice);
        checkExist = true;
        break;
      }
    }
    if (!checkExist) {
      cartInfo.add(cartProduct);
      totalPrice = await getPrice(cartProduct, totalPrice);
    }

    UtilsPreference.setTotalPrice(totalPrice);
    UtilsPreference.setCartInfo(cartInfo);
  }

  Future<double> getPrice(CartProduct cartProduct, double totalPrice) async {
    var tmp = await getProduct("getProduct/" + cartProduct.productId!);
    totalPrice = totalPrice + tmp.price * cartProduct.amount!;
    return totalPrice;
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.down,
    );
  }

  Future<dynamic> updateCart(String uri, Cart cart) async {
    var jsonData = await callApi(uri, "put",
        bodyParams: jsonEncode(cart.toJson3()),
        header: {'Content-Type': 'application/json; charset=UTF-8'});
    return jsonData;
  }

  Future<Product> getProduct(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Product.fromJson(jsonData);
  }
}
