import 'package:flutter/material.dart';
import 'package:for_capstone/size_config.dart';

import '../../../constants.dart';
import '../../../domains/repository/product.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.productName ?? "",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: kDefaultPadding),
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                flex: 6,
                child: Hero(
                  tag: "${product.productId}",
                  child: Image.asset(
                    "assets/images/gas.png",                    
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
