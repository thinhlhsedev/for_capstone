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
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/gspspring2022.appspot.com/o/Images%2F"+orderDetail.product!.imageUrl),
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
                      child: buildText(context, "T??n: ", orderDetail.product!.productName.toUpperCase()),                      
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: buildText(context, "S??? l?????ng: ", orderDetail.amount.toString()),                      
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
                        getPrice(orderDetail.price!) + ".000 vnd",
                        style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
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

  Future<Product> get(String uri) async {
    var jsonData = await callApi(uri, "get");
    return Product.fromJson(jsonData);
  }

  String getPrice(double price) {
    var tmp = price.toString().split(".")[0];
    var tmp2 = "";
    var count = 0;
    var tmp3 = ""; 
  
    for (int i = tmp.length - 1; i >= 0; i--) {
      tmp2 = tmp2 + tmp[i];
      if (count == 2 && i!= 0) {
        
        tmp2 = tmp2 + ".";
        count = 0;
      } else {
        count++;
      }      
    }
    for (int i = tmp2.length - 1; i >= 0; i--) {
      tmp3 = tmp3 + tmp2[i];
    }
    return tmp3;
  }
}
