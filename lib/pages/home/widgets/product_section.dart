import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/product.dart';
import 'product_card.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loadProductData("getProducts/Active");
  }

  FutureBuilder<dynamic> loadProductData(String uri) {
    return FutureBuilder<dynamic>(
      future: get(uri),
      builder: (context, snapshot) {
        final products = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              heightFactor: 2,
              child: kSpinkit,
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
              var list = <Product>[];
              for (Product product in products) {
                if (!product.productId.contains('_')) {
                  list.add(product);
                }
              }              
              return buildProductList(list);
            }
        }
      },
    );
  }

  Future<dynamic> get(String uri) async {
    var jsonData = await callApi(uri, "get");
    var list = jsonData.cast<Map<String, dynamic>>();
    return list.map<Product>((json) => Product.fromJson(json)).toList();
  }

  ListView buildProductList(List<Product> productList) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Padding(
            padding: const EdgeInsets.only(
              right: kDefaultPadding,
              left: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: ProductCard(
              product: product,
              press: () {},
            ),
          );
        },
      );
}
