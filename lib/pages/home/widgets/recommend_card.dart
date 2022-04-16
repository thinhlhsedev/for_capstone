import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class RecommendCard extends StatelessWidget {
  const RecommendCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title;
  final int price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: SizeConfig.screenWidth * 0.4,
      child: Column(
        children: [
          Image.asset("assets/images/gas.png"),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: "$title\n".toUpperCase(),
                        style: Theme.of(context).textTheme.button),
                  ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      text: '\$$price',
                      style: Theme.of(context).textTheme.button!.copyWith(color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
