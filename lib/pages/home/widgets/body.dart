import 'package:flutter/material.dart';
import 'package:for_capstone/pages/home/widgets/product_section.dart';

import '../../../constants.dart';
import '../../product/views/product_page.dart';
import 'header_with_banner.dart';
import 'title_with_btn.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderWithBanner(),
          TitleWithMoreBtn(
              title: "Bếp gas",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductPage(),
                  ),
                );
              }),
          const ProductSection(),
          const SizedBox(height: kDefaultPadding / 2),
        ],
      ),
    );
  }
}
