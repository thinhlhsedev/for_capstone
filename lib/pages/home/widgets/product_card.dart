import 'package:flutter/material.dart';
import 'package:for_capstone/pages/gasstove_detail/views/gasstove_detail_page.dart';
import 'package:for_capstone/pages/product/widgets/rounded_icon_btn.dart';

import '../../../constants.dart';
import '../../../domains/repository/product.dart';
import '../../../size_config.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.press,
    required this.product,
  }) : super(key: key);

  final VoidCallback press;
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late int number;

  @override
  void initState() {
    super.initState();
    number = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [kDefaultShadow]),
      child: InkWell(
        onTap: widget.press,
        child: Row(
          children: [
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
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
                    text: widget.product.productName ?? "",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "${widget.product.price} vnd",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    RoundedIconBtn(
                      icon: Icons.remove,
                      showShadow: true,
                      press: () {
                        setState(() {
                          if (number != 1) {
                            number--;
                          }
                        });
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
                        setState(() {
                          number++;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GasStoveDetailPage(product: widget.product),
                  ),
                );
              },
              child: const Icon(Icons.arrow_forward_ios_outlined,
                  color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
