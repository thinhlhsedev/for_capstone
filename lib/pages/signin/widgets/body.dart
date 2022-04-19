import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/domains/api/api_method_mutipart.dart';
import 'package:for_capstone/domains/utils/utils_preference.dart';
import 'package:for_capstone/pages/signin/widgets/background.dart';
import 'package:for_capstone/size_config.dart';

import '../../../domains/api/api_google.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/account.dart';
import '../../../domains/repository/cart.dart';
import '../../home/views/home_page.dart';
import 'rounded_icon_btn.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

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
          isLoading == false
              ? RoundedButton(
                  text: "Đăng nhập với Google",
                  press: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await signIn(context);
                    setState(() {
                      isLoading = false;
                    });
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: kPrimaryColor,
                    strokeWidth: 6,
                  ),
                ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
        ],
      ),
    );
  }

  Future signIn(BuildContext context) async {
    final account = await GoogleSignInAPI.login();

    if (account != null) {
      var accountFetch = await getAccount("getAccountByEmail/" + account.email);
      if (accountFetch.isActive == true) {
        UtilsPreference.setAccount(accountFetch);
        UtilsPreference.setPhoto(account.photoUrl!);

        try {
          var cartFetch = await getCart(
              "getCartByAccountId/" + accountFetch.accountId.toString());
          UtilsPreference.setCart(cartFetch);
        } on Exception {
          try {
            var cartFetch = Cart(accountId: accountFetch.accountId);
            addCart("addCart", cartFetch);
          } on Exception {
            ScaffoldMessenger.of(context).showSnackBar(
              buildSnackBar("Create cart failed"),
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            buildSnackBar("Cart is error"),
          );
        }

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          buildSnackBar("Your account is locked"),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        buildSnackBar("Try to login by another account"),
      );
    }
  }

  Future<Account> getAccount(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Account.fromJson(jsonData);
  }

  Future<Cart> getCart(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Cart.fromJson(jsonData);
  }

  Future<Cart> addCart(String uri, Cart cart) async {
    var jsonData =
        await callApiMultipart(uri, "post", bodyParams: cart.toJson2());
    return Cart.fromJson(jsonData);
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.down,
    );
  }
}
