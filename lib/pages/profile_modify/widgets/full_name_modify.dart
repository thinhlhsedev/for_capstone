import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';

import 'package:for_capstone/domains/utils/account_preference.dart';
import 'package:for_capstone/pages/profile_modify/widgets/notify_message.dart';
import 'package:for_capstone/size_config.dart';

import '../../../domains/api/api_method.dart';
import '../../../domains/repository/account.dart';

class FullNameModiFy extends StatefulWidget {
  const FullNameModiFy({
    Key? key,
  }) : super(key: key);

  @override
  State<FullNameModiFy> createState() => _FullNameModiFyState();
}

class _FullNameModiFyState extends State<FullNameModiFy> {
  TextEditingController textFieldController =
      TextEditingController(text: AccountPreference.getDisplayname());
  bool isButtonActive = false;
  late String newName, tmpText;
  final formKey = GlobalKey<FormState>();
  late Account account;

  @override
  void initState() {
    super.initState();
    textFieldController.addListener(() {
      var isButtonActive = textFieldController.text.isNotEmpty;
      tmpText = AccountPreference.getDisplayname() ?? "";
      setState(() {
        if (textFieldController.text == tmpText) {
          isButtonActive = false;
        }
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textFieldController,
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Fill your full name",
                  contentPadding:
                      const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  border: const OutlineInputBorder(),
                  suffixIcon: textFieldController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          onPressed: () {
                            textFieldController.clear();
                          },
                          icon: const Icon(Icons.close),
                        ),
                  prefixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.red[300],
                  ),
                ),
                validator: (value) {
                  return checkText(value!);
                },
                onSaved: (value) => setState(() {
                  newName = value!;
                }),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isButtonActive
                    ? () async {
                        setState(() => isButtonActive = true);
                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          formKey.currentState!.save();
                        }
                        await update();
                      }
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
                  "Save Changes",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> update() async {
    var account =
        await get("getAccountByEmail/" + (AccountPreference.getEmail() ?? ""));    
    account.name = newName;
    var result = await put("https://98af-171-250-246-4.ngrok.io/updateAccount", account);
    if (result == "Update Successfully") {
      var updateAccount = await get(
          "getAccountByEmail/" + (AccountPreference.getEmail() ?? ""));
      AccountPreference.setAccount(updateAccount);
      const NotifyMessage(
        text: "Update successfully",
      );
    }
  }

  checkText(String text) {
    const namePattern = r'[^?!0-9$&+,:;=?@#|' '<>.^*()%!-]* ';
    final nameRegExp = RegExp(namePattern);

    if (!nameRegExp.hasMatch(text)) {
      return "Enter a valid full name";
    } else {
      var list = text.split(" ");
      list.remove(" ");
      if (list.length < 2) {
        return "Full name need at least 2 words";
      }
      return null;
    }
  }

  Future<Account> get(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Account.fromJson(jsonData);
  }

  Future<String> put(String uri, Account account) async {
    var jsonData = await callApi(uri, "put", bodyParams: account.toJson(), header: {'Content-Type':'application/json'});
    return jsonDecode(jsonData);
  }
}
