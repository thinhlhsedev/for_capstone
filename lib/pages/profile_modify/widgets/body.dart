import 'package:flutter/material.dart';
import 'package:for_capstone/pages/profile_modify/widgets/email_modify.dart';
import 'package:for_capstone/pages/profile_modify/widgets/full_name_modify.dart';
import 'package:for_capstone/pages/profile_modify/widgets/gender_modify.dart';
import 'package:for_capstone/pages/profile_modify/widgets/phone_modify.dart';
import 'package:for_capstone/pages/profile_modify/widgets/title_modify.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TitleModify(text: text),
              const SizedBox(height: 10),
              getModify(text),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
            color: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget getModify(String text) {
    switch (text) {
      case "Full Name":
        return const FullNameModiFy();
      case "Email":
        return const EmailModiFy();
      case "Gender":
        return const GenderModify();
      case "Phone":
        return const PhoneModiFy();
      default:
        return Container();
    }
  }
}
