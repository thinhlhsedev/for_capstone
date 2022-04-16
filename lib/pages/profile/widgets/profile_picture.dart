import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';

import '../../../domains/utils/utils_preference.dart';

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
        children: [
          CircleAvatar(
            child: CircleAvatar(
              backgroundImage: NetworkImage(UtilsPreference.getPhoto() ?? ""),
              maxRadius: 107,
            ),
            backgroundColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
