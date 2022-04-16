import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/product.dart';
import 'product_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          loadProductData("getProducts"),          
        ],
      ),
    );
  }

  FutureBuilder<dynamic> loadProductData(String uri) {
    return FutureBuilder<dynamic>(
      future: get(uri),
      builder: (context, snapshot) {
        final products = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              heightFactor: 16,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: kPrimaryColor,
                strokeWidth: 6,
              ),
            );
          default:
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else {
              return Expanded(
                child: buildProductList(products),
              );
            }
        }
      },
    );
  }

  ListView buildProductList(List<Product> productList) => ListView.builder(
        shrinkWrap: true,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: ProductCard(
              product: product,
              press: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => OrderDetailPage(
                //       orderId: order.orderId!,
                //     ),
                //   ),
                // );
              },
            ),
          );
        },
      );

  Future<dynamic> get(String uri) async {
    var jsonData = await callApi(uri, "get");
    var list = jsonData.cast<Map<String, dynamic>>();
    return list.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
