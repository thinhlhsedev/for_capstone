import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/repository/product.dart';
import '../../../size_config.dart';
import 'rounded_icon_btn.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
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
            RichText(
              text: TextSpan(
                text: product.productName ?? "",
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: "\$${product.price}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
            ),
            Row(
              children: [
                RoundedIconBtn(
                  icon: Icons.remove,
                  showShadow: true,
                  press: () {},
                ),
                Container(                  
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenHeight(40), 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),                   
                  ),                 
                  child: const Center(
                    child: Text("3"),
                  ),
                ),
                RoundedIconBtn(
                  icon: Icons.add,
                  showShadow: true,
                  press: () {},
                ),
              ],
            )
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
