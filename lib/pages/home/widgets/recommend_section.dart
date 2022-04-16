import 'package:flutter/material.dart';

import '../../gasstove_detail/views/gasstove_detail_page.dart';
import 'recommend_card.dart';

class RecommendSection extends StatelessWidget {
  const RecommendSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          RecommendCard(
            image: "assets/images/gas.png",
            title: "Gas 1",
            price: 440,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GasStoveDetailPage(),
                ),
              );
            },
          ),
          RecommendCard(
            image: "assets/images/gas.png",
            title: "Gas 2",
            price: 440,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GasStoveDetailPage(),
                ),
              );
            },
          ),
          RecommendCard(
            image: "assets/images/gas.png",
            title: "Gas 3",
            price: 440,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GasStoveDetailPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
