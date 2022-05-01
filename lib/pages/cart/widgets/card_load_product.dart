import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:shimmer/shimmer.dart';

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
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[400]!,
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
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
