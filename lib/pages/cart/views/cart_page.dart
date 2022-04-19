import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/repository/product.dart';
import '../../../domains/utils/utils_preference.dart';
import '../widgets/body.dart';
import '../widgets/check_out_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: const CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: Column(
        children: [
          const Text(
            "Giỏ Hàng",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            "Số lượng: " + getTotalItem().toString() + " sản phẩm",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  getTotalItem() {
    var jsonData = jsonDecode(UtilsPreference.getCartInfo() ?? "");
    var list = jsonData.cast<Map<String, dynamic>>();
    var num = list.map<Product>((json) => Product.fromJson(json)).toList();
    return num.length;
  }
}
