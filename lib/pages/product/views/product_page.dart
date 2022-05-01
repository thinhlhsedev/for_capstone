import 'package:flutter/material.dart';


import '../../../constants.dart';
import '../widgets/body.dart';
import '../widgets/cart_with_number.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      //bottomNavigationBar: ,
    );
  }  

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: const Text(
        "Bếp Gas",
      ),
      centerTitle: true,
      //leading: ,
      actions: const [
        CartWithNumber(),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
