import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';

import '../widgets/body.dart';
import '../widgets/bottom_nav_bar.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(orderId: orderId,),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: const Text("Chi tiết đơn hàng"),
      centerTitle: true,
    );
  }
}
