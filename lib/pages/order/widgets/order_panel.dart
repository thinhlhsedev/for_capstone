import 'package:for_capstone/constants.dart';
import 'package:for_capstone/domains/utils/utils_preference.dart';
import 'package:for_capstone/pages/order/widgets/order_card.dart';

import 'package:flutter/material.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/order.dart';
import '../../order_detail/views/order_detail_page.dart';
import 'all_order_card.dart';

class OrderPanel extends StatelessWidget {
  const OrderPanel({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    switch (orderStatus) {
      case "Tất cả đơn":
        return loadOrderData(
            "getOrdersOf/acc/" + UtilsPreference.getAccountId().toString());
      case "Chờ xác nhận":
        return loadOrderData("getOrderOf/" +
            UtilsPreference.getAccountId().toString() +
            "/Pending");
      case "Đang xử lý":
        return loadOrderData("getOrderOf/" +
            UtilsPreference.getAccountId().toString() +
            "/Processing");
      case "Đang vận chuyển":
        return loadOrderData("getOrderOf/" +
            UtilsPreference.getAccountId().toString() +
            "/Delivering");
      case "Đã hoàn tất":
        return loadOrderData("getOrderOf/" +
            UtilsPreference.getAccountId().toString() +
            "/Completed");
      case "Đã hủy":
        return loadOrderData("getOrderOf/" +
            UtilsPreference.getAccountId().toString() +
            "/Canceled");
      default:
        return const Center(
          child: Text("Lỗi"),
        );
    }
  }

  FutureBuilder<dynamic> loadOrderData(String uri) {
    return FutureBuilder<dynamic>(
      future: get(uri),
      builder: (context, snapshot) {
        final orders = snapshot.data;
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
              if (orders.isEmpty) {
                return Container(
                  padding: const EdgeInsets.only(top: 220),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/search_property.png",                        
                        height: 80,
                        color: kPrimaryColor,
                      ),
                      const Text(
                        "Chưa có đơn hàng nào",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                );
              }
              return Expanded(
                child: uri.contains("getOrdersOf/acc/") 
                ? buildAllOrderList(orders)
                : buildOrderList(orders),
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
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailPage(
                    orderId: order.orderId!,
                  ),
                ),
              );
            },
          );
        },
      );

  ListView buildAllOrderList(List<Order> orderList) => ListView.builder(
        shrinkWrap: true,
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return AllOrderCard(
            order: order,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailPage(
                    orderId: order.orderId!,
                  ),
                ),
              );
            },
          );
        },
      );
}
