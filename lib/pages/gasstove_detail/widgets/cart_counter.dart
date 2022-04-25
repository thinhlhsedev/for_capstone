import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'rounded_icon_btn.dart';

class CartCounter extends StatefulWidget {
  CartCounter({
    Key? key,
    required this.number,
  }) : super(key: key);

  int number;

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      children: [
        RoundedIconBtn(
          icon: Icons.remove,
          press: () {
            if (widget.number > 0) {
              setState(() {
                widget.number--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            widget.number.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        RoundedIconBtn(
            icon: Icons.add,
            press: () {
              setState(() {
                widget.number++;
              });
            }),
      ],
    );
  }
}
