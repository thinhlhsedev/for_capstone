import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/domains/utils/utils_preference.dart';
import 'package:for_capstone/size_config.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../domains/repository/account.dart';

class EmailModiFy extends StatefulWidget {
  const EmailModiFy({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailModiFy> createState() => _EmailModiFyState();
}

class _EmailModiFyState extends State<EmailModiFy> {
  TextEditingController textFieldController =
      TextEditingController(text: UtilsPreference.getEmail());
  bool isButtonActive = false;
  late String newEmail, tmpEmail;
  final formKey = GlobalKey<FormState>();
  late Account account;

  @override
  void initState() {
    super.initState();
    textFieldController.addListener(() {
      var isButtonActive = textFieldController.text.isNotEmpty;
      tmpEmail = UtilsPreference.getEmail()!;
      setState(() {
        if (textFieldController.text == tmpEmail) {
          isButtonActive = false;
        }
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textFieldController,
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(                  
                  hintText: "Nhập email của bạn",
                  contentPadding:
                      const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  border: const OutlineInputBorder(),
                  suffixIcon: textFieldController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          onPressed: () {
                            textFieldController.clear();
                          },
                          icon: const Icon(Icons.close),
                        ),
                  prefixIcon: Icon(Icons.email_outlined,
                      color: Colors.red[300],),
                ),
                validator: EmailValidator(errorText: "Nhập email phù hợp"),
                onSaved: (value) => setState(() {
                  newEmail = value!;
                }),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isButtonActive
                    ? () {
                        setState(() => isButtonActive = true);
                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          formKey.currentState!.save();
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
                  "Lưu thay đổi",
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
}
