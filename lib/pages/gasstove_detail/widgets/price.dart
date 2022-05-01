import 'package:flutter/material.dart';

import '../../../domains/repository/product.dart';

class Price extends StatelessWidget {
  const Price({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: "Giá\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 33,
                color: Colors.black.withOpacity(0.7),
              )),
          const TextSpan(
            text: "Liên hệ thêm",
            style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black54,
            ),               
          ),
        ],
      ),
    );
  }
}
