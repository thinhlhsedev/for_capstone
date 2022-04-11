import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../widgets/body.dart';

class ProfileModifyPage extends StatelessWidget {
  const ProfileModifyPage({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(text),
      body: Body(text: text),
    );
  }

  AppBar buildAppBar(String text) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: Text(text),
    );
  }
}
