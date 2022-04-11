import 'package:flutter/material.dart';

import 'product_card.dart';

class Product extends StatelessWidget {
  const Product({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ProductCard(
          image: "assets/images/gas.png",
          title: "Gas 1",
          number: 3,
          price: 440,
        ),
        ProductCard(
          image: "assets/images/gas.png",
          title: "Gas 2",
          number: 4,
          price: 440,
        ),
        ProductCard(
          image: "assets/images/gas.png",
          title: "Gas 3",
          number: 5,
          price: 440,
        ),
      ],
    );
  }
}
