import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/order_detail.dart';
import '../../../domains/repository/product.dart';
import '../../../size_config.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard({
    Key? key,
    required this.orderDetail,
    required this.press,
  }) : super(key: key);

  final OrderDetail orderDetail;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      height: 160,
      child: InkWell(
        onTap:press,
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
            Positioned(
              top: 0,
              right: -8,
              child: Hero(
                tag: '${orderDetail.productId}',
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 160,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 200,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/gas.png"),
                    //NetworkImage(product.imageUrl ?? ""),
                    maxRadius: 107,
                    backgroundColor: kPrimaryColor,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                width: SizeConfig.screenWidth - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Tên: " + (orderDetail.product!.productName ?? "").toUpperCase(),
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Số lượng: " + (orderDetail.amount.toString()),
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),                    
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "Đơn giá: \$${orderDetail.price}",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Product> get(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Product.fromJson(jsonData);
  }
}
