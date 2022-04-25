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
          TextSpan(
            text: getPrice(product.price) + ".000 vnd",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black54,
            ),               
          ),
        ],
      ),
    );
  }

  String getPrice(double price){   
    var tmp = ""; 
    if (price >= 1000)
    {
      tmp = (price/1000).toString();
      if (tmp.length == 3)
      {
        tmp = tmp + "00";
      }
      if (tmp.length == 4)
      {
        tmp = tmp + "0";
      }
    } else {
      tmp = price.floor().toString();
    }
    return tmp;
  }
}
