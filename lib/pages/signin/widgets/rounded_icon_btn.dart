import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_capstone/size_config.dart';

import '../../../constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: SizeConfig.screenWidth * 0.8,
      child: newElevatedButton(),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: SvgPicture.asset(
          "assets/icons/google.svg",
          height: 30,
        ),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: kPrimaryColor, width: 1.5),
        ),
        elevation: 3,
      ),
    );
  }
}
