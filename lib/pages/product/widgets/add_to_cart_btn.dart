import 'package:flutter/material.dart';

import '../../../constants.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
      decoration: const BoxDecoration(
        
      ),
      child: ElevatedButton(        
        onPressed: () {},
        child: const Text(
          "Add to cart",
          style: TextStyle(fontSize: 19),
        ),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          primary: kPrimaryColor,         
        ),
      ),
    );
  }
}
