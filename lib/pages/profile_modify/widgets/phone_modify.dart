import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/size_config.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../domains/api/api_method_mutipart.dart';
import '../../../domains/repository/account.dart';
import '../../../domains/utils/utils_preference.dart';
import '../../profile/views/profile_page.dart';

enum MobileVerificationState {
  showMobileFormState,
  showOTPFormState,
}

class PhoneModiFy extends StatefulWidget {
  const PhoneModiFy({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneModiFy> createState() => _PhoneModiFyState();
}

class _PhoneModiFyState extends State<PhoneModiFy> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController phoneController = TextEditingController(
      text: UtilsPreference.getPhone() != ""
          ? "+84" + UtilsPreference.getPhone()!.substring(1)
          : null);
  TextEditingController otpController = TextEditingController();
  var currentState = MobileVerificationState.showMobileFormState;
  bool isButtonActive = true, showLoading = false;
  late String newPhone, tmpPhone, verificationId;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      var isButtonActive = phoneController.text.isNotEmpty;
      UtilsPreference.getPhone() != ""
          ? tmpPhone = "+84" + UtilsPreference.getPhone()!.substring(1)
          : tmpPhone = "";
      setState(() {
        if (phoneController.text == tmpPhone) {
          isButtonActive = false;
        }
        this.isButtonActive = isButtonActive;
      });
    });
    otpController.addListener(() {
      var isButtonActive = otpController.text.isNotEmpty;
      this.isButtonActive = isButtonActive;
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showLoading
          ? const Center(
              child: kSpinkit,
            )
          : currentState == MobileVerificationState.showMobileFormState
              ? getPhoneWidget()
              : getOTPWidget(),
    );
  }

  Column getPhoneWidget() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: phoneController,
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Nh???p s??? ??i???n tho???i c???a b???n",
                  contentPadding:
                      const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  border: const OutlineInputBorder(),
                  suffixIcon: phoneController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          onPressed: () {
                            phoneController.clear();
                          },
                          icon: const Icon(Icons.close),
                        ),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.red[300],
                  ),
                ),
                validator: PatternValidator(
                    r'((\+84)+(9|3|7|8|5)+([0-9]{8})\b)',
                    errorText: "??i???n s??? ??i???n tho???i ph?? h???p (+84)"),
                onSaved: (value) => setState(() {
                  newPhone = value!;
                }),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isButtonActive
                    ? () async {
                        setState(() {
                          isButtonActive = true;
                          showLoading = true;
                        });

                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          formKey.currentState!.save();

                          await auth.verifyPhoneNumber(
                            phoneNumber: newPhone,
                            verificationCompleted: (PhoneAuthCredential
                                phoneAuthCredential) async {
                              setState(() {
                                showLoading = false;
                              });
                            },
                            verificationFailed:
                                (FirebaseAuthException e) async {
                              setState(() {
                                showLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                buildSnackBar(
                                  "??i???n s??? ??i???n tho???i ph?? h???p",
                                ),
                              );
                            },
                            codeSent: (String verificationId,
                                int? resendToken) async {
                              setState(() {
                                showLoading = false;
                                currentState =
                                    MobileVerificationState.showOTPFormState;
                                this.verificationId = verificationId;
                              });
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) async {},
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(10),
                  minimumSize: Size(SizeConfig.screenWidth, 20),
                  onSurface: Colors.grey,
                  primary: kPrimaryColor,
                ),
                child: const Text(
                  "L??u thay ?????i",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column getOTPWidget() {
    return Column(
      children: [
        Form(
          key: scaffoldKey,
          child: Column(
            children: [
              TextFormField(
                controller: otpController,
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Nh???p m?? OTP",
                  contentPadding:
                      const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  border: const OutlineInputBorder(),
                  suffixIcon: otpController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          onPressed: () {
                            otpController.clear();
                          },
                          icon: const Icon(Icons.close),
                        ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.red[300],
                  ),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() => isButtonActive = false);
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);

                  signInWithPhoneAuthCredential(phoneAuthCredential);

                  Account account = Account.fromJson(
                    jsonDecode(UtilsPreference.getFullAccount() ?? ""),
                  );

                  account.phone = "0" + newPhone.substring(3);

                  await put("updateAccount", account);
                  UtilsPreference.setAccount(account);
                  buildSnackBar("???? l??u thay ?????i");
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(10),
                  minimumSize: Size(SizeConfig.screenWidth, 20),
                  onSurface: Colors.grey,
                  primary: kPrimaryColor,
                ),
                child: const Text(
                  "L??u thay ?????i",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<String> put(String uri, Account account) async {
    var jsonData =
        await callApiMultipart(uri, "put", bodyParams: account.toJson2());
    return jsonData;
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {}
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      scaffoldKey.currentState!.showBottomSheet(
        (context) => SnackBar(
          content: Text(
            e.message ?? "",
          ),
          dismissDirection: DismissDirection.down,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.down,
    );
  }
}
