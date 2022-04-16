import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuPadding extends StatelessWidget {
  const ProfileMenuPadding({
    Key? key,
    required this.press,
    required this.icon,
    required this.type,
  }) : super(key: key);

  final VoidCallback press;
  final String icon;
  final Widget type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),    
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.grey,
          padding: const EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,          
        ),
        onPressed: press,
        child: Row(
          children: [
            SizedBox(
              child: SvgPicture.asset(
                icon,
                color: Colors.black54,
                width: 22,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(child: type),
            const Icon(Icons.arrow_forward_ios, color: Colors.black54),
          ],
        ),
      ),
    );
  }  
}

