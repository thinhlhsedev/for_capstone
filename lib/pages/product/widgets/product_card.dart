import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_capstone/pages/gasstove_detail/views/gasstove_detail_page.dart';
import 'package:for_capstone/pages/product/widgets/rounded_icon_btn.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/cart.dart';
import '../../../domains/repository/cartproduct.dart';
import '../../../domains/repository/product.dart';
import '../../../domains/utils/utils_preference.dart';
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
    number = 0;
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
          ]),
      child: InkWell(
        onTap: widget.press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: widget.product.productName,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 16,
                        ),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    RoundedIconBtn(
                      icon: Icons.remove,
                      showShadow: true,
                      press: () {
                        setState(() {
                          if (number != 0) {
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
                    const SizedBox(width: 7),
                    RoundedIconBtn(
                      icon: Icons.add_shopping_cart_outlined,
                      showShadow: true,
                      press: () {
                        setState(() {
                          if (number != 0) {
                            try {
                              CartProduct cartProduct = CartProduct(
                                  productId: widget.product.productId,
                                  amount: number);
                              List<CartProduct> cartInfo = [];
                              var list = [];
                              if (UtilsPreference.getCartInfo() != null)
                              {
                                list = jsonDecode(UtilsPreference.getCartInfo()!);
                              }                              

                              checkCart(list, cartProduct, cartInfo);

                              Cart cart = setCart(cartInfo);

                              updateCart("updateCart", cart);

                              ScaffoldMessenger.of(context).showSnackBar(
                                buildSnackBar("Đã thêm vào giỏ hàng"),
                              );

                              setState(() {
                                number = 0;
                              });
                            } on Exception {
                              ScaffoldMessenger.of(context).showSnackBar(
                                buildSnackBar("Có lỗi với giỏ hàng"),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                buildSnackBar("Vui lòng tăng số lượng"));
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
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
              child: SvgPicture.asset(
                "assets/icons/information.svg",
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
    bool checkExist = false;

    for (int i = 0; i < len; i++) {
      if (cartInfo[i].productId == cartProduct.productId) {
        cartInfo[i].amount = cartInfo[i].amount! + cartProduct.amount!;
        checkExist = true;
        break;
      }
    }
    if (!checkExist) {
      cartInfo.add(cartProduct);
    }

    UtilsPreference.setCartInfo(cartInfo);
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.down,
    );
  }
}
