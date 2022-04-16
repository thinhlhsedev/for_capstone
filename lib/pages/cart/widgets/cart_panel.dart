import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_capstone/pages/cart/widgets/cart_card.dart';

import '../../../domains/repository/product.dart';
import '../../../size_config.dart';

class CartPanel extends StatefulWidget {
  const CartPanel({
    Key? key,
    required this.productList,
  }) : super(key: key);

  final List<Product> productList;

  @override
  State<CartPanel> createState() => _CartPanelState();
}

class _CartPanelState extends State<CartPanel> {
  late List<Product> productList;

  @override
  void initState() {
    super.initState();
    productList = widget.productList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(productList[index].productId.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                productList.removeAt(index);
                
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset("assets/icons/trash.svg"),
                ],
              ),
            ),
            child: CartCard(product: productList[index]),
          ),
        ),
      ),
    );
  }
}
