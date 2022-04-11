import 'package:flutter/material.dart';

import '../../gasstove_detail/views/gasstove_detail_page.dart';
import 'component_card.dart';

class Component extends StatelessWidget {
  const Component({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ComponentCard(
            image: "assets/images/gas.png",
            title: "Gas 1",
            country: "Russia",
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
          ComponentCard(
            image: "assets/images/gas.png",
            title: "Gas 2",
            country: "Viet Nam",
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
          ComponentCard(
            image: "assets/images/gas.png",
            title: "Gas 3",
            country: "Viet Nam",
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


