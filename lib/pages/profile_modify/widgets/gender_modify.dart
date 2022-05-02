import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_capstone/domains/api/api_method_mutipart.dart';
import 'package:for_capstone/pages/profile/views/profile_page.dart';

import '../../../constants.dart';
import '../../../domains/repository/account.dart';
import '../../../domains/utils/utils_preference.dart';
import '../../../size_config.dart';

class GenderModify extends StatefulWidget {
  const GenderModify({Key? key}) : super(key: key);

  @override
  State<GenderModify> createState() => _GenderModifyState();
}

class _GenderModifyState extends State<GenderModify> {
  late int selectedValue;
  late bool isButtonActive;
  late int check;

  @override
  void initState() {
    super.initState();
    switch (UtilsPreference.getGender()) {
      case "true":
        selectedValue = 1;
        break;
      case "false":
        selectedValue = 2;
        break;
      default:
        selectedValue = 0;
        break;
    }
    bool isButtonActive = false;
    check = selectedValue;
    setState(() {
      this.isButtonActive = isButtonActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<int>(
          contentPadding: const EdgeInsets.all(0),
          value: 1,
          groupValue: selectedValue,
          title: const Text("Nam"),
          activeColor: kPrimaryColor,
          onChanged: (value) {
            setState(() => selectedValue = 1);
          },
        ),
        RadioListTile<int>(
          contentPadding: const EdgeInsets.all(0),
          value: 2,
          groupValue: selectedValue,
          title: const Text("Nữ"),
          activeColor: kPrimaryColor,
          onChanged: (value) {
            setState(() => selectedValue = 2);
          },
        ),
        ElevatedButton(
          onPressed: check != selectedValue
              ? (() async {
                  setState(() => isButtonActive = true);
                  Account account = Account.fromJson(
                    jsonDecode(UtilsPreference.getFullAccount() ?? ""),
                  );

                  switch (selectedValue) {
                    case 1:
                      account.gender = true;
                      break;
                    case 2:
                      account.gender = false;
                      break;
                  }
                  await put("updateAccount", account);
                  UtilsPreference.setAccount(account);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                })
              : null,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(10),
            minimumSize: Size(SizeConfig.screenWidth, 20),
            onSurface: Colors.grey,
            primary: kPrimaryColor,
          ),
          child: const Text(
            "Lưu thay đổi",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Future<String> put(String uri, Account account) async {
    var jsonData =
        await callApiMultipart(uri, "put", bodyParams: account.toJson2());
    return jsonData;
  }
}
