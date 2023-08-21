import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Information_page extends StatefulWidget {
  const Information_page({super.key});

  @override
  State<Information_page> createState() => _Information_pageState();
}

class _Information_pageState extends State<Information_page> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController ageController = TextEditingController();

  int age = 0;

  @override
  Widget build(BuildContext context) {
    User? user = Get.arguments as User?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Information page"),
      ),
      body: Container(alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

               Text(
                "Enter your Age",
                style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w500,fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ageController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter age first..";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    age = int.parse(val!);
                    print("${age}");
                  });
                },
                decoration: const InputDecoration(
                  label: Text("Age"),
                  hintText: "Enter your age",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    if (age >= 18) {
                      Get.snackbar(
                        "You can vote",
                        "Your age is able for vote",
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                     setState(() {
                       ageController.clear();
                     });
                      Get.offAllNamed('/',arguments: user);
                    } else {
                      Get.snackbar(
                        "You can't vote",
                        "Your age isn't able for vote",
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
