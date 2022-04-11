import 'package:flutter/material.dart';
import 'package:for_capstone/constants.dart';
import 'package:for_capstone/size_config.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailModiFy extends StatefulWidget {
  const EmailModiFy({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailModiFy> createState() => _EmailModiFyState();
}

class _EmailModiFyState extends State<EmailModiFy> {
  TextEditingController textFieldController = TextEditingController();
  bool isButtonActive = true;
  late String text, error;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textFieldController.addListener(() {
      final isButtonActive = textFieldController.text.isNotEmpty;
      setState(() {
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
                  //alignLabelWithHint: true,
                  hintText: "Fill your email",
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
                validator: EmailValidator(errorText: "Enter valid email"),
                onSaved: (value) => setState(() {
                  text = value!;
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
                  "Save Changes",
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
