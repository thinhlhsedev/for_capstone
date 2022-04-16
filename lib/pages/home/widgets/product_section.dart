import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ProductCard(
          image: "assets/images/gas.png",
          title: "Gas 1",
          number: 1,
          price: 440,
        ),
        ProductCard(
          image: "assets/images/gas.png",
          title: "Gas 2",
          number: 1,
          price: 440,
        ),
        ProductCard(
          image: "assets/images/gas.png",
          title: "Gas 3",
          number: 1,
          price: 440,
        ),
      ],
    );
  }
}
