import 'package:flutter/material.dart';
import 'package:for_capstone/domains/repository/product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 238, 238),                
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/images/gas1.png"),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.productName ?? "",
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${product.price}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${product.amount}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}