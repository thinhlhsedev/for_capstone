import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OvaledIconBtn extends StatelessWidget {
  const OvaledIconBtn({
    Key? key,
    required this.text,
    required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final String text;
  final GestureTapCancelCallback press;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(80),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 10,
              color: const Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: TextButton(        
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: kPrimaryColor,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
        ),
        onPressed: press,
        child: Text(text),
      ),
    );
  }
}