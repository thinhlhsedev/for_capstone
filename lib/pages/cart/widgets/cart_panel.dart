import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/pages/cart/widgets/cart_card.dart';

import '../../../domains/api/api_method.dart';
import '../../../domains/repository/product.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: kDefaultPadding,
          left: kDefaultPadding,
          bottom: kDefaultPadding),
      child: ListView.builder(
        itemCount: widget.productList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.productList[index].productId!),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                widget.productList.removeAt(index);
                //UtilsPreference.setCartInfo(productList);
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
            child: CartCard(product: widget.productList[index]),
          ),
        ),
      ),
    );
  }

  Future<Product> getAccount(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Product.fromJson(jsonData);
  }
}
