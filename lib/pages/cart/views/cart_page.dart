import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_capstone/pages/cart/widgets/check_out_card.dart';
import 'package:for_capstone/pages/general/views/general_page.dart';

import '../../../constants.dart';
import '../../../domains/utils/utils_preference.dart';
import '../widgets/body.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: const CheckoutCart(),
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const GeneralPage(chosenIndex: 0,)),
          );
        },
      ),
    );
  }

  getTotalItem() {
    List list = jsonDecode(UtilsPreference.getCartInfo()!);
    return list.length;
  }
}
