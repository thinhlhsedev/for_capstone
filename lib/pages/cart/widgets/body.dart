import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/pages/cart/widgets/cart_panel.dart';

import '../../../domains/repository/cartproduct.dart';
import '../../../domains/utils/utils_preference.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<CartProduct> listCartProduct = [];

  @override
  void initState() {
    super.initState();
    listCartProduct = buildListCartProduct();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: refreshList,
      child: Column(
        children: [
          Expanded(
            child: CartPanel(
              list: listCartProduct,
            ),
          ),        
        ],
      ),
    );
  }

  List<CartProduct> buildListCartProduct() {
    var list = jsonDecode(UtilsPreference.getCartInfo()!);
    return list.map<CartProduct>((json) => CartProduct.fromJson(json)).toList();
  }
  
  Future<void> refreshList() async 
  {
    await Future.delayed(const Duration(seconds: 1),);
    listCartProduct = buildListCartProduct();
  }
}
