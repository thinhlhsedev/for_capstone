import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/size_config.dart';

import '../widgets/body.dart';
import '../widgets/cart_with_number.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
      leading: Container(
        margin: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
        child: Image.asset(
          "assets/images/logo.png",
          color: Colors.white,
        ),
      ),
      actions: const [
        CartWithNumber(),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
