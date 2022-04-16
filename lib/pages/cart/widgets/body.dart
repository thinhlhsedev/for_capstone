import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_capstone/pages/cart/widgets/cart_panel.dart';

import '../../../domains/api/api_method.dart';
import '../../../domains/repository/cart.dart';
import '../../../domains/repository/product.dart';
import '../../../domains/utils/utils_preference.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<Product> listProduct;

  @override
  void initState() {
    super.initState();
    listProduct = buildListProduct();
  }

  @override
  Widget build(BuildContext context) {
    return CartPanel(productList: listProduct);
  }

  buildListProduct() {
    var jsonData = jsonDecode(UtilsPreference.getCartInfo() ?? "");
    var list = jsonData.cast<Map<String, dynamic>>();
    return list.map<Product>((json) => Product.fromJson(json)).toList();
  }

  Future<Cart> get(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Cart.fromJson(jsonData);
  }
}
