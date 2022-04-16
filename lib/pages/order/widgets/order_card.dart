import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/repository/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
    required this.press,
  }) : super(key: key);

  final Order order;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: kPrimaryColor,
                boxShadow: const [kDefaultShadow],
              ),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            SizedBox(
              height: 126,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      "Mã đơn hàng: " + order.orderId.toString(),
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      "Địa chỉ: " + (order.customerAddress ?? ""),
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      "Ngày giao hàng dự kiến: " +
                          getDate(order.expiryDate!.substring(0, 10)),
                      style: Theme.of(context).textTheme.button,
                    ),
                  ), // it use the a
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      order.isShorTerm == true
                          ? "Loại: đơn lẻ"
                          : "Loại: đơn định kì",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      buildPricePadding("\$${order.totalPrice}"),
                      const Spacer(),
                      buildDetailPadding("Detail", context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDetailPadding(String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 1.5,
        vertical: kDefaultPadding / 4,
      ),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container buildPricePadding(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 1.5,
        vertical: kDefaultPadding / 4,
      ),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  String getDate(String date) {
    Iterable<String> list = date.split("-").reversed;
    String result = list.first + "-" + list.elementAt(1) + "-" + list.last;
    return result;
  }
}
