import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../domains/utils/utils_preference.dart';
import '../../../size_config.dart';

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
  String address = UtilsPreference.getAddress()!, tmpAddress = "";
  bool isButtonActive = false;
  double width = kDefaultPadding, height = kDefaultPadding;

  @override
  void initState() {
    super.initState();
    textFieldController.addListener(() {
      var isButtonActive = textFieldController.text.isNotEmpty;
      tmpAddress = address;
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
                padding: const EdgeInsets.all(10),
                height: getProportionateScreenWidth(40),
                width: getProportionateScreenWidth(40),
                decoration: BoxDecoration(
                  //color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset("assets/icons/receipt.svg"),
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
                    textStyle: const TextStyle(
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
                          style: TextStyle(
                              color:
                                  address == "" ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "Tổng tiền:\n",
                  children: [
                    TextSpan(
                      text: getTotalPrice().toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(190),
                child: ElevatedButton(
                  onPressed: isButtonActive == true
                      ? () {
                          setState(() {
                            address = textFieldController.text;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    textStyle: const TextStyle(fontSize: 18),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
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
        ],
      ),
    );
  }

  Future<dynamic> buildAddressPopUp() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Địa chỉ của bạn",
          style: TextStyle(color: kPrimaryColor),
        ),
        content: TextField(
          controller: textFieldController,
          onChanged: (value) {},
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(),
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: Colors.black,
            ),
            hintText: 'Nhập địa chỉ',
            hintStyle: TextStyle(color: kPrimaryColor),
          ),
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                address = textFieldController.text;
                UtilsPreference.setAddress(address);
                Navigator.of(context).pop();
              });
            },
            child: const Text(
              "Lưu",
              style: TextStyle(color: kPrimaryColor),
            ),
          )
        ],
      ),
    );
  }

  getTotalPrice() {
    double totalPrice = UtilsPreference.getTotalPrice()!;
    return totalPrice;
  }
}
