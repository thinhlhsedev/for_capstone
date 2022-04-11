import 'package:for_capstone/constants.dart';
import 'package:for_capstone/pages/order/widgets/order_card.dart';

import 'package:flutter/material.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/order.dart';

class OrderPanel extends StatelessWidget {
  const OrderPanel({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    switch (orderStatus) {
      case "All Order":
        return loadOrderData("getAllOrders");
      case "Processing":
        return loadOrderData("getOrders/Processing");
      case "Completed":
        return loadOrderData("getOrders/Completed");
      case "Canceled":
        return loadOrderData("getOrders/Canceled");
      default:
        return const Center(
          child: Text("Exception"),
        );
    }
  }

  FutureBuilder<dynamic> loadOrderData(String uri) {
    return FutureBuilder<dynamic>(
      future: get(uri),
      builder: (context, snapshot) {
        final order = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Padding(
              padding: EdgeInsets.only(top: 220),
              child: CircularProgressIndicator(
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
                child: buildOrderList(order),
              );
            }
        }
      },
    );
  }

  Future<dynamic> get(String uri) async {
    var jsonData = await callApi(uri, "get");
    var list = jsonData.cast<Map<String, dynamic>>();
    return list.map<Order>((json) => Order.fromJson(json)).toList();
  }

  ListView buildOrderList(List<Order> orderList) => ListView.builder(
        shrinkWrap: true,
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return OrderCard(
            order: order,
            press: () {},
          );
        },
      );
}
