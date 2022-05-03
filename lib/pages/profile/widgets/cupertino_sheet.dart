import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method_mutipart.dart';
import '../../../domains/repository/account.dart';
import '../../../domains/utils/utils_preference.dart';
import '../../../size_config.dart';

class CupertinoSheet extends StatefulWidget {
  const CupertinoSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CupertinoSheet> createState() => _CupertinoSheetState();
}

class _CupertinoSheetState extends State<CupertinoSheet> {
  late DateTime selectedDate;
  late DateTime firstDate;
  late bool isButtonActive;
  late String tmpDate;

  @override
  void initState() {
    super.initState();
    if (UtilsPreference.getDOB()! != "") {
      tmpDate = UtilsPreference.getDOB()!.substring(0, 10);
      selectedDate = DateTime.parse(tmpDate);
    } else {
      selectedDate = DateTime.now();
    }
    firstDate = selectedDate;
    isButtonActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        SizedBox(
          height: SizeConfig.screenHeight / 3,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (picked) {
              setState(() {
                if (picked != selectedDate) {
                  selectedDate = picked;
                  if (selectedDate == firstDate) {
                    isButtonActive = false;
                  } else {
                    isButtonActive = true;
                  }
                }
              });
            },
            initialDateTime: selectedDate,
            minimumYear: 1900,
            maximumDate: DateTime.now(),
          ),
        ),
      ],
      cancelButton: ElevatedButton(
        onPressed: isButtonActive
            ? () async {
                setState(() => isButtonActive = false);
                Account account = Account.fromJson(
                  jsonDecode(UtilsPreference.getFullAccount() ?? ""),
                );                
                account.dateOfBirth =
                    DateFormat("yyyy-MM-dd").format(selectedDate);
                await put("updateAccount", account);                
                UtilsPreference.setAccount(account);
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar("Đã lưu thay đổi"),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(SizeConfig.screenWidth, 60),
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
    );
  }

  Future<String> put(String uri, Account account) async {
    var jsonData =
        await callApiMultipart(uri, "put", bodyParams: account.toJson2());
    return jsonData;
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.down,
    );
  }
}
