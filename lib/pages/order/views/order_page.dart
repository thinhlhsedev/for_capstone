import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';

import '../widgets/body.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: buildAppBar(),
        body: const Body(),    
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: const Text("Đơn Hàng Của Tôi"),    
      centerTitle: true,
      automaticallyImplyLeading: false, 
    );
  }
}
