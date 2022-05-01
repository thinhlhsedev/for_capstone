import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/pages/cart/widgets/card_load_product.dart';

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
      child: widget.list.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: widget.list.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(widget.list[index].productId!),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    widget.list.removeAt(index);
                    if (widget.list.isEmpty) {
                      UtilsPreference.setCartInfo(<CartProduct>[]);
                      Cart cart = setCart(<CartProduct>[]);
                      updateCart("updateCart", cart);
                    } else {
                      UtilsPreference.setCartInfo(widget.list);
                      Cart cart = setCart(widget.list);
                      updateCart("updateCart", cart);
                    }
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
                  child: CardLoadProduct(
                      productId: widget.list[index].productId!,
                      number: widget.list[index].amount!),
                ),
              ),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 220,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/gas_stove.png",
                      height: 80,
                      color: kPrimaryColor,
                    ),
                    const Text(
                      "Chưa có sản phẩm nào",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  FutureBuilder<dynamic> loadProductData(String uri, int number) {
    return FutureBuilder<dynamic>(
      future: getProduct(uri),
      builder: (context, snapshot) {
        final product = snapshot.data;
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

  Cart setCart(List<CartProduct> cartInfo) {
    var cart = Cart.fromJson3(jsonDecode(UtilsPreference.getFullCart()!));
    cart.cartInfo = cartInfo;
    UtilsPreference.setFullCart(cart);
    return cart;
  }
}
