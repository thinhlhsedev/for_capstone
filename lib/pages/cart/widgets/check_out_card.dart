import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_capstone/domains/repository/cart.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../domains/api/api_method.dart';
import '../../../domains/repository/cartproduct.dart';
import '../../../domains/repository/order.dart';
import '../../../domains/repository/order_detail.dart';
import '../../../domains/utils/utils_preference.dart';
import '../../../size_config.dart';
import '../../general/views/general_page.dart';

class CheckoutCart extends StatefulWidget {
  const CheckoutCart({Key? key}) : super(key: key);

  @override
  State<CheckoutCart> createState() => _CheckoutCartState();
}

class _CheckoutCartState extends State<CheckoutCart> {
  TextEditingController textFieldController = TextEditingController(
      text: UtilsPreference.getAddress() == "address"
          ? ""
          : UtilsPreference.getAddress());
  TextEditingController textFieldController2 = TextEditingController();
  String address = UtilsPreference.getAddress() ?? "";
  String note = "";
  bool isButtonActive = false;
  double width = kDefaultPadding, height = kDefaultPadding;

  @override
  void initState() {
    super.initState();
    if (address == "" || getTotalItem() == 0) {
      isButtonActive = false;
    } else {
      isButtonActive = true;
    }
    textFieldController.addListener(() {
      var isButtonActive = textFieldController.text.isNotEmpty;
      this.isButtonActive = isButtonActive;
    });
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildCheckOut();
  }

  Container buildCheckOut() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: width,
        horizontal: height,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [kDefaultShadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                //padding: const EdgeInsets.all(10),
                height: getProportionateScreenWidth(30),
                width: getProportionateScreenWidth(30),
                decoration: BoxDecoration(
                  //color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: buildNotePopUp,
                  child: SvgPicture.asset(
                    "assets/icons/receipt.svg",
                    color: note != ""
                        ? kPrimaryColor
                        : Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: SizeConfig.screenWidth * 0.65,
                child: ElevatedButton(
                  onPressed: () {
                    buildAddressPopUp();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: address == "" ? kPrimaryColor : kBackgroundColor,
                    textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 18,
                        ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: address == "" ? Colors.white : Colors.black,
                      ),
                      Expanded(
                        child: Text(
                          address == "" ? "Nhập địa chỉ" : address,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: address == ""
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.8),
                                fontSize: 14,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          SizedBox(
            width: SizeConfig.screenWidth,
            child: ElevatedButton(
              onPressed: isButtonActive == true
                  ? () {
                      buildConfirmDialog();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                textStyle: const TextStyle(fontSize: 18),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              child: const Text(
                "Xác nhận đơn",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildConfirmDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Xác nhận đơn",
          style: TextStyle(color: kPrimaryColor),
        ),
        content: Text(
          "Bạn đồng ý với thông tin đơn hàng ?",
          style: Theme.of(context).textTheme.button!.copyWith(
                color: Colors.black.withOpacity(0.7),
                fontSize: 16,
              ),
        ),
        actions: [
          buildTextButton(context, () {
            var list = buildListCartProduct();
            var listOrderDetail = <OrderDetail>[];
            for (var cartProduct in list) {
              OrderDetail orderDetail = OrderDetail(
                productId: cartProduct.productId,
                amount: cartProduct.amount,
              );
              listOrderDetail.add(orderDetail);
            }
            Order order = Order(
              accountId: UtilsPreference.getAccountId(),
              customerAddress: address,
              customerName: UtilsPreference.getDisplayname(),
              orderDetails: listOrderDetail,
              status: "Pending",
              isShorTerm: true,
              note: note,
              expiryDate: DateFormat("dd/MM/yy").format(DateTime.now()),
            );

            addOrder("addOrder/2", order);

            var cart = Cart(
                cartId: UtilsPreference.getCartId(),
                accountId: UtilsPreference.getAccountId(),
                cartInfo: null,
                totalPrice: 0);
            updateCart("updateCart", cart);
            UtilsPreference.setCart(cart);

            buildSuccessPopup();
          }, "Tiếp tục"),
          buildTextButton(context, () {
            Navigator.of(context).pop();
          }, "Không"),
        ],
      ),
    );
  }

  Future<dynamic> buildSuccessPopup() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 80,
          child: Column(
            children: [
              Image.asset(
                "assets/images/check.png",
                color: kPrimaryColor,
                height: 50,
              ),
              const SizedBox(height: 10),
              const Text(
                "Đơn hàng đã được yêu cầu",
              ),
            ],
          ),
        ),
        actions: [
          buildTextButton(
            context,
            () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const GeneralPage(chosenIndex: 0,)),
              );
            },
            "Quay về màn hính chính",
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildAddressPopUp() {
    return buildDialog(
      "Địa chỉ của bạn",
      textFieldController,
      "Nhập địa chỉ",
      Icons.location_on_outlined,
      () {
        setState(() {
          address = textFieldController.text;
          UtilsPreference.setAddress(address);
          Navigator.of(context).pop();
        });
      },
    );
  }

  Future<dynamic> buildNotePopUp() {
    return buildDialog(
      "Ghi chú",
      textFieldController2,
      "Nhập ghi chú",
      Icons.notes_outlined,
      () {
        setState(() {
          note = textFieldController2.text;
          Navigator.of(context).pop();
        });
      },
    );
  }

  Future<dynamic> buildDialog(String title, TextEditingController controller,
      String hintext, IconData icon, VoidCallback press) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: kPrimaryColor),
        ),
        content: TextField(
          controller: controller,
          maxLines: 5,
          minLines: 1,
          onChanged: (value) {},
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(),
            border: const OutlineInputBorder(),
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            hintText: hintext,
            hintStyle: const TextStyle(color: kPrimaryColor),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
        ),
        actions: [
          buildTextButton(
            context,
            press,
            "Lưu thay đổi",
          )
        ],
      ),
    );
  }

  TextButton buildTextButton(
      BuildContext context, VoidCallback press, String text) {
    return TextButton(
      onPressed: press,
      child: Text(
        text,
        style: Theme.of(context).textTheme.button!.copyWith(
              color: kPrimaryColor,
              fontSize: 16,
            ),
      ),
    );
  }

  getTotalPrice() {
    double totalPrice = UtilsPreference.getTotalPrice()!;
    return totalPrice;
  }

  Future<dynamic> updateCart(String uri, Cart cart) async {
    var jsonData = await callApi(uri, "put",
        bodyParams: jsonEncode(cart.toJson3()),
        header: {'Content-Type': 'application/json; charset=UTF-8'});
    return jsonData;
  }

  Future<String> addOrder(String uri, Order order) async {
    var jsonData = await callApi(uri, "post",
        bodyParams: jsonEncode(order.toJson2()),
        header: {'Content-Type': 'application/json; charset=UTF-8'});
    return jsonData;
  }

  List<CartProduct> buildListCartProduct() {
    var list = jsonDecode(UtilsPreference.getCartInfo()!);
    return list.map<CartProduct>((json) => CartProduct.fromJson(json)).toList();
  }

  getTotalItem() {
    List list = jsonDecode(UtilsPreference.getCartInfo()!);
    return list.length;
  }
}
