import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';

import '../widgets/body.dart';
import '../widgets/bottom_nav_bar.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: buildAppBar(),
        body: const Body(),
        bottomNavigationBar: const BottomNavBar(),      
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: const Text("Order"),      
    );
  }
}
