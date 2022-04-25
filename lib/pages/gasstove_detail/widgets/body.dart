import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/pages/gasstove_detail/widgets/price.dart';
import 'package:for_capstone/size_config.dart';

import '../../../domains/repository/product.dart';
import 'add_to_cart.dart';
import 'description.dart';
import 'product_tile_with_image.dart';
import 'rounded_icon_btn.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.90,
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
                      Description(product: widget.product),
                      const Spacer(),
                      Price(product: widget.product),
                      const SizedBox(height: kDefaultPadding),
                      buildCartCounter(context),
                      const SizedBox(height: kDefaultPadding),
                      AddToCart(
                        product: widget.product,
                        number: number,
                      ),
                    ],
                  ),
                ),
                ProductTitleWithImage(product: widget.product)
              ],
            ),
          )
        ],
      ),
    );
  }

  Row buildCartCounter(BuildContext context) {
    return Row(
      children: [
        RoundedIconBtn(
          icon: Icons.remove,
          press: () {
            if (number > 0) {
              setState(() {
                number--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            number.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        RoundedIconBtn(
            icon: Icons.add,
            press: () {
              setState(() {
                number++;
              });
            }),
      ],
    );
  }
}
