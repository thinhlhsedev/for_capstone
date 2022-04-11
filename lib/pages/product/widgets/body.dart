import 'package:flutter/material.dart';

import '../../../domains/repository/product.dart';
import '../../../size_config.dart';
import 'product_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: demoProduct.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ProductCard(
            product: demoProduct[index]
          ),           
        ),
      ),
    );   
  }
}