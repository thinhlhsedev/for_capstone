import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 220,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: const [
          CircleAvatar(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),         
              maxRadius: 107,
            ),            
            backgroundColor: kPrimaryColor,
          ),
          // Positioned(
          //   right: -16,
          //   bottom: 0,
          //   child: SizedBox(
          //     height: 46,
          //     width: 46,
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(50),
          //           side: const BorderSide(color: Colors.white),
          //         ),
          //         primary: Colors.white,
          //         backgroundColor: const Color(0xFFF5F6F9),
          //       ),
          //       onPressed: () {

          //       },
          //       child: SvgPicture.asset("assets/icons/camera.svg"),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
