import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../product/widgets/rounded_icon_btn.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.number,
    required this.price,
  }) : super(key: key);

  final String image, title;
  final double price;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 2,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Colors.transparent,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: Image.asset(image, fit: BoxFit.contain),
        title: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$title\n".toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                  ),
                  TextSpan(
                    text: '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            const Spacer(),
            RoundedIconBtn(
              icon: Icons.remove,
              showShadow: true,
              press: () {
                
              },
            ),
            Container(
              height: getProportionateScreenHeight(40),
              width: getProportionateScreenHeight(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(number.toString()),
              ),
            ),
            RoundedIconBtn(
              icon: Icons.add,
              showShadow: true,
              press: () {

              },
            ),
          ],
        ),
      ),
    );
  }  
}
