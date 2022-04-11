import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/utils/account_preference.dart';
import '../../../size_config.dart';

class CupertinoSheet extends StatefulWidget {
  const CupertinoSheet({Key? key}) : super(key: key);

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
    tmpDate = AccountPreference.getDOB()!.substring(0, 10);
    selectedDate = DateTime.parse(tmpDate);
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
            ? () {
                setState(() => isButtonActive = false);

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
          "Save Changes",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  
}
