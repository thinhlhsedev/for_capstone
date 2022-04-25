import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_capstone/pages/cart/widgets/cart_panel.dart';

import '../../../domains/api/api_method.dart';
import '../../../domains/repository/cartproduct.dart';
import '../../../domains/repository/product.dart';
import '../../../domains/utils/utils_preference.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<Product> listProduct = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartPanel(
          list: buildListCartProduct(),
        ),        
      ],
    );
  }

  List<CartProduct> buildListCartProduct() {
    var list = jsonDecode(UtilsPreference.getCartInfo()!);
    return list.map<CartProduct>((json) => CartProduct.fromJson(json)).toList();
  }

  Future<Product> getProduct(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Product.fromJson(jsonData);
  }
}
