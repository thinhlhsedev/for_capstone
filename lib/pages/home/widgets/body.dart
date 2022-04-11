import 'package:flutter/material.dart';

import '../../../constants.dart';

import '../../product/views/product_page.dart';
import 'product.dart';
import 'header_with_searchbox.dart';
import 'component.dart';
import 'title_with_btn.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const HeaderWithSearchBox(),
          TitleWithMoreBtn(
              title: "Components",
              press: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ()),
                //   ),
              }),
          const Component(),
          TitleWithMoreBtn(
              title: "Products",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductPage(),
                  ),
                );
              }),
          const Product(),
          const SizedBox(height: kDefaultPadding / 2),
        ],
      ),
    );
  }
}
