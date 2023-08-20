import 'package:advance_viva2_voting_app/helper/firebaseauth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  Map<String, dynamic> data = await FireBaseAuthHelper
                      .fireBaseAuthHelper
                      .signInWithGoogle();

                  if (data['user'] != null) {
                    Get.snackbar(
                        "SUCCESSFULLY", "Login Successfully with Google😊..",
                        backgroundColor: Colors.green);
                    Get.offNamed('/', arguments: data['user']);
                    // logINOutController.logInOutTrueValue();
                  } else {
                    Get.snackbar("FAILURE", data['msg'],
                        backgroundColor: Colors.red);
                  }
                },
                icon: Icon(Icons.g_mobiledata),
                label: Text("Sign in with google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
