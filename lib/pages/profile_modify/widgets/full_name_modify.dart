import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/domains/api/api_method_mutipart.dart';
import 'package:for_capstone/domains/utils/utils_preference.dart';
import 'package:for_capstone/size_config.dart';

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
      TextEditingController(text: UtilsPreference.getDisplayname());
  bool isButtonActive = false;
  late String newName, tmpName;
  final formKey = GlobalKey<FormState>();
  late Account account;

  @override
  void initState() {
    super.initState();
    textFieldController.addListener(() {
      var isButtonActive = textFieldController.text.isNotEmpty;
      tmpName = UtilsPreference.getDisplayname() ?? "";
      setState(() {
        if (textFieldController.text == tmpName) {
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
                  hintText: "Nhập tên đầy đủ của bạn",
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

                          Account account = Account.fromJson(
                            jsonDecode(UtilsPreference.getFullAccount() ?? ""),
                          );

                          account.name = newName;

                          put("updateAccount", account);
                          UtilsPreference.setAccount(account);
                          ScaffoldMessenger.of(context).showSnackBar(                            
                            buildSnackBar("Đã lưu thay đổi"),
                          );
                        }
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
                  "Lưu thay đổi",
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

  checkText(String text) {
    const namePattern = r'[^?!0-9$&+,:;=?@#|' '<>.^*()%!-]* ';
    final nameRegExp = RegExp(namePattern);

    if (!nameRegExp.hasMatch(text)) {
      return "Nhập tên phù hợp";
    } else {
      var list = text.split(" ");
      list.remove(" ");
      if (list.length < 2) {
        return "Tên của bạn cần ít nhất 2 từ";
      }
      return null;
    }
  }

  Future<String> put(String uri, Account account) async {
    var jsonData =
        await callApiMultipart(uri, "put", bodyParams: account.toJson2());
    return jsonData;
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 4),
      dismissDirection: DismissDirection.down,
    );
  }
}
