import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_capstone/domains/utils/utils_preference.dart';
import 'package:for_capstone/pages/gasstove_detail/views/gasstove_detail_page.dart';
import 'package:for_capstone/pages/product/widgets/rounded_icon_btn.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/cart.dart';
import '../../../domains/repository/cartproduct.dart';
import '../../../domains/repository/product.dart';
import '../../../size_config.dart';
import 'ovaled_icon_btn.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.product,
    required this.amount,
    required this.press,
  }) : super(key: key);

  final Product product;
  final int amount;
  final VoidCallback press;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int number = 0;
  int tmpNumber = 0;
  int chosenNumber = 0;
  var multiNumber = [1, 10, 100, 1000];

  @override
  void initState() {
    super.initState();
    number = widget.amount;
    tmpNumber = number;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 15),
            blurRadius: 27,
            color: Colors.black12
                .withOpacity(0.04), // Black color with 12% opacity
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          widget.press;
        },
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
                  child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/gspspring2022.appspot.com/o/Images%2F" +
                          widget.product.imageUrl),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 65,
                      child: Row(
                        //mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: RichText(
                                text: TextSpan(
                                  text: widget.product.productName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: 16,
                                      ),
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    OvaledIconBtn(
                      text: "x " + multiNumber[chosenNumber].toString(),
                      showShadow: true,
                      press: () {
                        setState(() {
                          switch (chosenNumber) {
                            case 3:
                              chosenNumber = 0;
                              break;
                            default:
                              chosenNumber++;
                              break;
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    RoundedIconBtn(
                      icon: Icons.remove,
                      showShadow: true,
                      press: () {
                        setState(() {
                          if (number != 0 &&
                              number >= multiNumber[chosenNumber]) {
                            number = number - multiNumber[chosenNumber];
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 5),
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
                    const SizedBox(width: 5),
                    RoundedIconBtn(
                      icon: Icons.add,
                      showShadow: true,
                      press: () {
                        setState(() {
                          if (number >= 10000) {
                            buildSnackBar(
                                "Không thể đặt hàng quá 10000 sản phẩm cùng loại");
                          } else {
                            number = number + multiNumber[chosenNumber];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: tmpNumber != number
                  ? () {
                      setState(() {
                        try {
                          CartProduct cartProduct = CartProduct(
                              productId: widget.product.productId,
                              amount: number);
                          List<CartProduct> cartInfo = [];
                          var list = jsonDecode(UtilsPreference.getCartInfo()!);

                          checkCart(list, cartProduct, cartInfo);

                          Cart cart = setCart(cartInfo);

                          updateCart("updateCart", cart);

                          ScaffoldMessenger.of(context).showSnackBar(
                            buildSnackBar("Đã cập nhật giỏ hàng"),
                          );
                        } on Exception {
                          ScaffoldMessenger.of(context).showSnackBar(
                            buildSnackBar("Có lỗi với giỏ hàng"),
                          );
                        }

                        tmpNumber = number;
                      });
                    }
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GasStoveDetailPage(product: widget.product),
                        ),
                      );
                    },
              child: tmpNumber != number
                  ? SvgPicture.asset(
                      "assets/icons/update_cart.svg",
                      height: 22,
                      color: kPrimaryColor,
                    )
                  : Image.asset(
                      "assets/images/information.png",
                      height: 22,
                      color: kPrimaryColor,
                    ),
            ),
          ],
        ),
      ),
    );
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

  void checkCart(
    list,
    CartProduct cartProduct,
    List<CartProduct> cartInfo,
  ) async {
    list.forEach((v) async {
      var productTmp = CartProduct.fromJson(v);
      cartInfo.add(productTmp);
    });

    var len = cartInfo.length;

    for (int i = 0; i < len; i++) {
      if (cartInfo[i].productId == cartProduct.productId) {
        cartInfo[i].amount = cartProduct.amount;
        break;
      }
    }
    UtilsPreference.setCartInfo(cartInfo);
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.down,
    );
  }
}
