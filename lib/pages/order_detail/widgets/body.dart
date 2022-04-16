import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';

import 'order_detail_panel.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kDefaultPadding / 2),
      child: Column(
        children: [
          OrderDetailPanel(
              orderId: orderId,
            ),
        ],
      ),
    );
  }
}
