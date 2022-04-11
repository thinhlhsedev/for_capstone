import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class GenderModify extends StatefulWidget {
  const GenderModify({Key? key}) : super(key: key);

  @override
  State<GenderModify> createState() => _GenderModifyState();
}

class _GenderModifyState extends State<GenderModify> {
  int selectedValue = 0;
  late bool isButtonActive;
  late int check;

  @override
  void initState() {
    super.initState();

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
          title: const Text("Male"),
          activeColor: kPrimaryColor,
          onChanged: (value) {
            setState(() => selectedValue = 1);
          },
        ),
        RadioListTile<int>(
          contentPadding: const EdgeInsets.all(0),
          value: 2,
          groupValue: selectedValue,
          title: const Text("Female"),
          activeColor: kPrimaryColor,
          onChanged: (value) {
            setState(() => selectedValue = 2);
          },
        ),        
        ElevatedButton(
          onPressed: selectedChange(check, selectedValue)
              ? (() {
                  setState(() => isButtonActive = true);
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
            "Save Changes",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  bool selectedChange(int check, int selectedValue) {
    return check != selectedValue;
  }
}
