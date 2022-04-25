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
    currentIndex = 2;
  }
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: kPrimaryColor,
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      iconSize: 28,
      onTap: (index) => setState(() {   
        currentIndex = index;    
        
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => screen[currentIndex]),
          );
      }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shop),
          label: "Order",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: "Profile",
        ),
      ],
    );
  }
}

