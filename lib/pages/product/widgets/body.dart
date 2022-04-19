import 'package:flutter/material.dart';
import 'package:for_capstone/pages/gasstove_detail/views/gasstove_detail_page.dart';
import 'package:for_capstone/pages/product/widgets/search_box.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/product.dart';
import 'product_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<Product> listProduct = [];
  late String searchValue;

  @override
  void initState() {
    super.initState();
    searchValue = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearch(),
        searchValue == ""
            ? Expanded(
                child: loadProductData("getProducts/Active"),
              )
            : Expanded(
                child: buildProductList(listProduct),
              ),
      ],
    );
  }

  SearchBox buildSearch() => SearchBox(onChanged: (value) {
        setState(() {
          searchValue = value;
          searchProduct(searchValue);
        });
      });

  FutureBuilder<dynamic> loadProductData(String uri) {
    return FutureBuilder<dynamic>(
      future: get(uri),
      builder: (context, snapshot) {
        listProduct = snapshot.data;
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
              return buildProductList(listProduct);
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
          return Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
            child: ProductCard(
              product: product,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GasStoveDetailPage(product: product),
                  ),
                );
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

  searchProduct(String query) {
    if (listProduct.isEmpty) {
      getProductList();
    }
    final suggestion = listProduct.where((product) {
      final productName = product.productName!.toLowerCase();
      final input = query.toLowerCase();

      return productName.contains(input);
    }).toList();
    setState(() {
      if (suggestion.isNotEmpty) {
        listProduct = suggestion;
        searchValue = query;
      }
    });
  }

  void getProductList() async {
    listProduct = await get("getProducts/Active");
  }
}
