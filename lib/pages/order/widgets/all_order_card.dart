import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/repository/order.dart';

class AllOrderCard extends StatelessWidget {
  const AllOrderCard({
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
      height: 200,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 180,
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
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: buildText(
                        context, "Mã đơn hàng: ", order.orderId.toString()),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: buildText(
                        context, "Địa chỉ: ", order.customerAddress.toString()),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: buildText(
                      context,
                      "Ngày giao hàng dự kiến: ",
                      order.expiryDate != null
                          ? getDate(order.expiryDate!.substring(0, 10))
                          : "Chưa cấp",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: buildText(
                      context,
                      "Loại: ",
                      order.isShorTerm == true ? "đơn lẻ" : "đơn định kì",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: buildText(
                        context, "Trạng thái: ", getStatus(order.status!)),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      buildPricePadding(
                          getPrice(order.totalPrice!) + ".000 vnd"),
                      const Spacer(),
                      buildDetailPadding("Chi tiết", context),
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

  RichText buildText(BuildContext context, String title, String content) {
    return RichText(
      text: TextSpan(
        text: title,
        style:
            Theme.of(context).textTheme.button!.copyWith(color: kPrimaryColor),
        children: [
          TextSpan(
            text: content,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.grey[700]),
          )
        ],
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

  String getStatus(String status) {
    switch (status) {
      case "Pending":
        return "Chờ xác nhận";
      case "Processing":
        return "Đang xử lý";
      case "Delivering":
        return "Đang vận chuyển";
      case "Completed":
        return "Đã hoàn tất";
      default:
        return "Đã hủy";
    }
  }

  String getPrice(double price) {
    var tmp = "";

    if (9999 < price && price <= 999999) {
      tmp = (price / 100000).toString();
    } else if (999999 < price && price <= 99999999) {
      tmp = (price / 10000000).toString();
    }

    if (tmp.length == 3) {
      tmp = tmp + "00";
    }
    if (tmp.length == 4) {
      tmp = tmp + "0";
    }
    return tmp;
  }
}
