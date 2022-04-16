import 'package:for_capstone/constants.dart';

import 'package:flutter/material.dart';
import 'package:for_capstone/size_config.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/order_detail.dart';
import 'order_detail_card.dart';

class OrderDetailPanel extends StatelessWidget {
  const OrderDetailPanel({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return loadOrderDetailData(
        "getOrderDetailAndProductOf/ord/" + orderId.toString());
  }

  FutureBuilder<dynamic> loadOrderDetailData(String uri) {
    return FutureBuilder<dynamic>(
      future: getOrderDetailList(uri),
      builder: (context, snapshot) {
        final orderDetails = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Padding(
              padding: EdgeInsets.only(top: 220, left: SizeConfig.screenWidth /2),
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: kPrimaryColor,
                strokeWidth: 6,
              ),
            );
          default:
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else {
              return Expanded(
                child: buildOrderDetailList(orderDetails),
              );
            }
        }
      },
    );
  }

  Future<dynamic> getOrderDetailList(String uri) async {
    var jsonData = await callApi(uri, "get");
    var list = jsonData.cast<Map<String, dynamic>>();
    return list.map<OrderDetail>((json) => OrderDetail.fromJson(json)).toList();
  }

  ListView buildOrderDetailList(List<OrderDetail> orderDetailList) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: orderDetailList.length,
        itemBuilder: (context, index) {
          final orderDetail = orderDetailList[index];
          return OrderDetailCard(
            orderDetail: orderDetail,
            press: () {},
          );
        },
      );
}
