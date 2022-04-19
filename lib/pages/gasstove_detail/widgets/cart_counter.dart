import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'rounded_icon_btn.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedIconBtn(
          icon: Icons.remove,
          press: () {
            if (number > 0) {
              setState(() {
                number--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            number.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        RoundedIconBtn(
            icon: Icons.add,
            press: () {
              setState(() {
                number++;
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData? icon, VoidCallback? press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
