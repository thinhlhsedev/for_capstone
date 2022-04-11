import 'package:flutter/material.dart';

import 'profile_padding.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.icon,
    required this.press,
    required this.titleText,
    required this.contentText,
  }) : super(key: key);

  final String titleText, icon, contentText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    if (titleText.contains("Change Password") ||
        titleText.contains("Log Out")) {
      return ProfileMenuPadding(
        press: press,
        icon: icon,
        type: onlyTitle(titleText),
      );
    }
    return ProfileMenuPadding(
      press: press,
      icon: icon,
      type: titleAndContent(titleText, contentText),
    );
  }
}

Widget titleAndContent(String titleText, String contentText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        contentText,
        style: const TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget onlyTitle(String titleText) {
  return Text(
    titleText,
    style: const TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: Colors.black,
    ),
  );
}
