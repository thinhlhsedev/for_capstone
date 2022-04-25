import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_capstone/constants.dart';

import '../../../domains/api/api_method.dart';
import '../../../domains/repository/cart.dart';
import '../../../domains/repository/cartproduct.dart';
import '../../../domains/repository/product.dart';
import '../../../domains/utils/utils_preference.dart';
import '../../gasstove_detail/views/gasstove_detail_page.dart';
import 'cart_card.dart';

class CartPanel extends StatefulWidget {
  const CartPanel({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<CartProduct> list;

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
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.list[index].productId!),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() async {
                var product = await getProduct(
                    "getProduct/" + widget.list[index].productId!);
                var subtractPrice =
                    product.price * widget.list[index].amount!.toDouble();
                var totalPrice = UtilsPreference.getTotalPrice()!;
                var remain = totalPrice - subtractPrice;

                UtilsPreference.setTotalPrice(remain);
                UtilsPreference.setCartInfo(widget.list);

                Cart cart = setCart(widget.list, remain);

                updateCart("updateCart", cart);

                widget.list.removeAt(index);
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
            child: loadProductData(
                "getProduct/" + (widget.list[index].productId ?? ""),
                (widget.list[index].amount ?? 0)),
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> loadProductData(String uri, int number) {
    return FutureBuilder<dynamic>(
      future: getProduct(uri),
      builder: (context, snapshot) {
        var product = snapshot.data;
        return CartCard(
          product: product,
          amount: number,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GasStoveDetailPage(product: product),
              ),
            );
          },
        );
      },
    );
  }

  Future<Product> getProduct(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Product.fromJson(jsonData);
  }

  Future<dynamic> updateCart(String uri, Cart cart) async {
    var jsonData = await callApi(uri, "put",
        bodyParams: jsonEncode(cart.toJson3()),
        header: {'Content-Type': 'application/json; charset=UTF-8'});
    return jsonData;
  }

  Cart setCart(List<CartProduct> cartInfo, double totalPrice) {
    var cart = Cart.fromJson3(jsonDecode(UtilsPreference.getFullCart()!));
    cart.cartInfo = cartInfo;
    cart.totalPrice = totalPrice;
    UtilsPreference.setFullCart(cart);
    return cart;
  }
}
