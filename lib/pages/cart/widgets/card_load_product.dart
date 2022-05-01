import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/product.dart';
import '../../gasstove_detail/views/gasstove_detail_page.dart';
import 'cart_card.dart';

class CardLoadProduct extends StatefulWidget {
  const CardLoadProduct(
      {Key? key, required this.number, required this.productId})
      : super(key: key);

  final int number;
  final String productId;

  @override
  State<CardLoadProduct> createState() => _CardLoadProductState();
}

class _CardLoadProductState extends State<CardLoadProduct> {
  List<Product> list = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getProduct("getProduct/" + widget.productId),
      builder: (context, snapshot) {
        var product = snapshot.data;        
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              heightFactor: 3,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: kPrimaryColor,
                strokeWidth: 6,
              ),              
            );
          default:
            return CartCard(
              product: product,
              amount: widget.number,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GasStoveDetailPage(product: product),
                  ),
                );
              },
            );
        }
      },
    );
  }

  Future<Product> getProduct(String uri) async {
    var jsonData = await callApi(uri, "get");    
    return Product.fromJson(jsonData);
  }
}
