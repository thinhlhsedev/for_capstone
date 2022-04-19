import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_capstone/size_config.dart';

import '../../../constants.dart';
import '../../../domains/repository/product.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding, horizontal: kDefaultPadding),
      height: SizeConfig.screenHeight*0.11,
      color: Colors.white,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: kDefaultPadding),    
            //height: 50,                    
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),  
                topRight: Radius.circular(24),
              )
            ),      
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
                color: kPrimaryColor,
              ),
              onPressed: () {
                
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  primary: kPrimaryColor,
                ),
                onPressed: () {},
                child: Text(
                  "Thêm vào giỏ hàng".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
