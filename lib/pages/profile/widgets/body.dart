import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:for_capstone/domains/utils/account_preference.dart';
import 'package:for_capstone/pages/signin/views/sign_in_page.dart';


import '../../../domains/api/api_google.dart';
import '../../profile_modify/views/profile_modify_page.dart';
import 'cupertino_sheet.dart';
import 'profile_menu.dart';
import 'profile_picture.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late DateTime selectedDate;
  late DateTime firstDate;
  late String tmpDate;
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    tmpDate = AccountPreference.getDOB()!.substring(0, 10);
    selectedDate = DateTime.parse(tmpDate);
    firstDate = selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            titleText: "Full Name",
            contentText: AccountPreference.getDisplayname() ?? "",
            icon: "assets/icons/user.svg",
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileModifyPage(
                    text: "Full Name",
                  ),
                ),
              ),
            },
          ),
          ProfileMenu(
            titleText: "Birthday",
            contentText: getDate(tmpDate),
            icon: "assets/icons/calendar.svg",
            press: () {
              buildCupertinoActionSheet(context);
            },
          ),
          ProfileMenu(
            titleText: "Gender",
            contentText: AccountPreference.getGender() == null
                ? AccountPreference.getGender() == "true"
                    ? "Male"
                    : "Female"
                : "Empty",
            icon: "assets/icons/gender.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileModifyPage(
                    text: "Gender",
                  ),
                ),
              );
            },
          ),
          ProfileMenu(
            titleText: "Phone",
            contentText: AccountPreference.getPhone() ?? "",
            icon: "assets/icons/address_book.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileModifyPage(
                    text: "Phone",
                  ),
                ),
              );
            },
          ),
          ProfileMenu(
            titleText: "Email",
            contentText: AccountPreference.getEmail() ?? "",
            icon: "assets/icons/envelope.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileModifyPage(
                    text: "Email",
                  ),
                ),
              );
            },
          ),
          ProfileMenu(
            titleText: "Log Out",
            contentText: "",
            icon: "assets/icons/log_out.svg",
            press: () {
              logOut(context);
            },
          ),
        ],
      ),
    );
  }

  buildCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return const CupertinoSheet();
      },
    );
  }

  Future logOut(BuildContext context) async {
    await GoogleSignInAPI.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SigninPage()),
    );
  }

  String getDate(String date) {
    Iterable<String> list = date.split("-").reversed;
    String result = list.first + "-" + list.elementAt(1) + "-" + list.last;
    return result;
  }
}
