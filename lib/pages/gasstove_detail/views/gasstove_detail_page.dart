import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/pages/gasstove_detail/widgets/add_to_cart.dart';

import '../../../domains/repository/product.dart';
import '../widgets/body.dart';
import '../widgets/cart_with_number.dart';

class GasStoveDetailPage extends StatelessWidget {

  final Product product;

  const GasStoveDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(product: product),
      bottomNavigationBar: AddToCart(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: const Text("Chi tiết sản phẩm"),
      centerTitle: true,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back_arrow.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: const [
        CartWithNumber(),
        SizedBox(width: kDefaultPadding / 2)
      ],
    );
  }
}
