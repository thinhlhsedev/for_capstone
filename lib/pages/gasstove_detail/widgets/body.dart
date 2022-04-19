import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/pages/gasstove_detail/widgets/cart_counter.dart';
import 'package:for_capstone/pages/gasstove_detail/widgets/price.dart';
import 'package:for_capstone/size_config.dart';

import '../../../domains/repository/product.dart';
import 'add_to_cart.dart';
import 'description.dart';
import 'product_tile_with_image.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.774,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.3,
                  ),
                  padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.04,
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: kDefaultPadding / 2),
                      Description(product: product),
                      //const SizedBox(height: kDefaultPadding / 2),
                      const Spacer(),
                      Price(product: product),
                      const SizedBox(height: kDefaultPadding),                      
                      const CartCounter(),
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
