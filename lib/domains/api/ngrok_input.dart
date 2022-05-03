import 'package:flutter/material.dart';
import 'package:for_capstone/domains/api/api_url.dart';
import 'package:for_capstone/pages/signin/views/sign_in_page.dart';

class Ngrok extends StatelessWidget {
  const Ngrok({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();
    
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 90,),
          TextField(
            controller: textFieldController,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              //ApiUrl.host = textFieldController.text.substring(8);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SigninPage()),
              );
            },
            child: const Text("Enter"),
          ),
        ],
      ),
    );
  }
}
