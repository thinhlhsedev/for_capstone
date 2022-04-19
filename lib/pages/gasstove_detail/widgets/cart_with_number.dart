import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domains/utils/utils_preference.dart';
import '../../cart/views/cart_page.dart';

class CartWithNumber extends StatelessWidget {
  const CartWithNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(                    
          icon: SvgPicture.asset("assets/icons/shopping_cart.svg"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
        ),
        Positioned(
          right: 2,
          top: 5,
          child: SizedBox(
            height: 18,
            width: 18,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.white),
              child: Center(
                child: Text(
                  getTotalItem().toString(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  getTotalItem() {
    List list = jsonDecode(UtilsPreference.getCartInfo()!);
    return list.length;
  }
}
