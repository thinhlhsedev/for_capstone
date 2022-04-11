import 'package:flutter/material.dart';
import 'package:for_capstone/pages/order/widgets/category_with_list_item.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: const CategoryList(),      
    );
  }
}
