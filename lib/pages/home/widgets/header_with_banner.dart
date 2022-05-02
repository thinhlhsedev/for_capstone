import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:for_capstone/size_config.dart';

import '../../../constants.dart';

class HeaderWithBanner extends StatefulWidget {
  const HeaderWithBanner({Key? key}) : super(key: key);

  @override
  State<HeaderWithBanner> createState() => _HeaderWithBannerState();
}

class _HeaderWithBannerState extends State<HeaderWithBanner> {
  late int current;
  List<String> imageList = [
    "assets/images/stove_banner.png",
    "assets/images/stove_banner2.png"
  ];

  @override
  void initState() {
    super.initState();
    current = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      height: SizeConfig.screenHeight * 0.35,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 46 + kDefaultPadding,
            ),
            height: SizeConfig.screenHeight * 0.2 - 16,
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Colors.red,
              //     kPrimaryColor
              //   ]
              // ),
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bếp Gas Uyên Phát",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              height: 180,
              decoration: BoxDecoration(               
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [kDefaultShadow],
              ),
              child: SizedBox(
                width: SizeConfig.screenWidth,
                height: 180,
                child: Swiper(
                  onIndexChanged: (index) {
                    setState(() {
                      current = index;
                    });
                  },
                  autoplay: true,
                  layout: SwiperLayout.DEFAULT,
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                            imageList[index],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
