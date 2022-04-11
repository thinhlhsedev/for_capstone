import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_capstone/pages/product/widgets/add_to_cart_btn.dart';

import '../../../constants.dart';
import '../../cart/views/cart_page.dart';
import '../widgets/body.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: const AddToCartBtn(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: const Text(
        "Products",
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/shopping_cart.svg"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
        ),       
      ],
    );
  }
}
