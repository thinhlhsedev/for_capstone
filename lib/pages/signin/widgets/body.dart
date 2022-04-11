import 'package:flutter/material.dart';
import 'package:for_capstone/domains/utils/account_preference.dart';
import 'package:for_capstone/pages/signin/widgets/background.dart';
import 'package:for_capstone/size_config.dart';

import '../../../domains/api/api_google.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/account.dart';
import '../../home/views/home_page.dart';
import 'rounded_btn.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Image.asset("assets/images/logo.png"),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          RoundedButton(
            text: "Login with Google",
            press: () {
              signIn(context);
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
        ],
      ),
    );
  }

  Future signIn(BuildContext context) async {
    final account = await GoogleSignInAPI.login();

    if (account != null) {
      await AccountPreference.setEmail(account.email);
      var accountFetch = await get("getAccountByEmail/" + account.email);
      if (accountFetch.isActive == true) {
        AccountPreference.setAccount(accountFetch);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        buildSnackBar("Your account is locked");
      }
    } else {
      buildSnackBar("Try to login by another account");
    }
  }

  Future<Account> get(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Account.fromJson(jsonData);
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.down,
    );
  }
}
