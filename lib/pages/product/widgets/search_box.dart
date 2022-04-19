import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  TextEditingController textFieldController =
      TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: kDefaultPadding / 4,
        right: kDefaultPadding,
        left: kDefaultPadding,
        bottom: kDefaultPadding / 2,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: textFieldController,
        onChanged: widget.onChanged,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: SvgPicture.asset("assets/icons/search.svg"),
          hintText: 'Tìm kiếm',
          hintStyle: const TextStyle(color: kPrimaryColor),
        ),
      ),
    );
  }
}
