import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../domains/utils/utils_preference.dart';
import '../../cart/views/cart_page.dart';

class CartWithNumber extends StatefulWidget {
  const CartWithNumber({Key? key}) : super(key: key);

  @override
  State<CartWithNumber> createState() => _CartWithNumberState();
}

class _CartWithNumberState extends State<CartWithNumber> {
  late int number = 0;

  @override
  void initState() {
    super.initState();
    number = getTotalItem();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            size: 33,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
        ),
        // Positioned(
        //   right: 2,
        //   top: 5,
        //   child: SizedBox(
        //     height: 18,
        //     width: 18,
        //     child: Container(
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(16), color: Colors.white),
        //       child: Center(
        //         child: Text(
        //           number.toString(),
        //           style: const TextStyle(
        //               color: Colors.black, fontWeight: FontWeight.w500),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  getTotalItem() {
    List list = jsonDecode(UtilsPreference.getCartInfo()!);
    return list.length;
  }  
}
