import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../home/views/home_page.dart';
import '../../order/views/order_page.dart';
import '../../profile/views/profile_page.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({
    Key? key,
    required this.chosenIndex,
  }) : super(key: key);

  final int chosenIndex;

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int currentIndex = 0;
  final screen = const [HomePage(), OrderPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: screen[currentIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: kPrimaryColor.withOpacity(0.5),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          backgroundColor: kBackgroundColor,
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          height: 70,
          onDestinationSelected: (newIndex) {
            setState(() {
              currentIndex = newIndex;
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (context) => screen[currentIndex]),
              // );
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shop),
              icon: Icon(Icons.shop_outlined),
              label: "Order",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
