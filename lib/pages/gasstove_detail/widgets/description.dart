import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/repository/product.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: "Mô tả\n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 33,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          TextSpan(
            text: product.description ?? "Không có mô tả",
            style: const TextStyle(     
              height: 1.5,         
              color: Colors.black54,
            ),
          ),
        ]),
      ),
    );
  }
}
