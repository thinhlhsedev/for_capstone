import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/repository/cart.dart';
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
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            demoCart.length.toString() + " items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
