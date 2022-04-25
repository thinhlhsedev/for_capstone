import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/pages/home/views/home_page.dart';
import 'package:for_capstone/pages/order/views/order_page.dart';
import 'package:for_capstone/pages/profile/views/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex;
  final screen = const [HomePage(), OrderPage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
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
            print("cur new:" + currentIndex.toString());            
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => screen[currentIndex]),
            );
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
    );
  }
}
