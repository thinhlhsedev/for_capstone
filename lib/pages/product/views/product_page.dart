import 'package:flutter/material.dart';
import 'package:for_capstone/pages/home/widgets/cart_with_number.dart';

import '../../../constants.dart';
import '../widgets/body.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      floatingActionButton: buildFloatingBtn(), 
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //bottomNavigationBar: ,
    );
  }

  FloatingActionButton buildFloatingBtn() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: kPrimaryColor,
      child: const Icon(Icons.add_shopping_cart_outlined, size: 25,),
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
      actions: const [
        CartWithNumber(),
      ],
    );
  }
}
