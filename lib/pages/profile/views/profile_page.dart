import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../widgets/body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
      title: const Text("Thông Tin Tài Khoản"),
      centerTitle: true,      
      automaticallyImplyLeading: false,
    );
  }
}
