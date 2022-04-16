import 'package:flutter/material.dart';
import 'package:for_capstone/domains/utils/utils_preference.dart';
import 'package:for_capstone/size_config.dart';

import '../widgets/body.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    UtilsPreference.init();
    return const Scaffold(
      body: const Body(),
    );
  }
}
