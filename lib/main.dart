import 'package:flutter/material.dart';
import 'package:for_capstone/domains/utils/account_preference.dart';
import 'package:for_capstone/pages/home/views/home_page.dart';
import 'package:for_capstone/pages/profile/views/profile_page.dart';
import 'package:for_capstone/pages/signin/views/sign_in_page.dart';
import 'constants.dart';
import 'pages/profile_modify/widgets/full_name_modify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AccountPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gas Stove App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SigninPage(),
    );
  }
}
