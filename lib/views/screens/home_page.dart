import 'package:advance_viva2_voting_app/controllers/login_out_controllers.dart';
import 'package:advance_viva2_voting_app/controllers/theme_controller.dart';
import 'package:advance_viva2_voting_app/helper/firebaseauth_helper.dart';
import 'package:advance_viva2_voting_app/helper/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  GlobalKey<FormState> adduserformkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  ThemeController themeController = Get.put(ThemeController());
  User? user = Get.arguments as User?;

  LogINOutController logINOutController = Get.put(LogINOutController());

  @override
  Widget build(BuildContext context) {
    // String args =  Get.arguments as String;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 70,
            ),
            CircleAvatar(
              radius: 60,
              foregroundImage: (user!.isAnonymous)
                  ? const AssetImage("assets/images/user.png") as ImageProvider
                  : NetworkImage("${user!.photoURL}"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            // (user!.isAnonymous)
            //     ? const Text("")
            //     : (user.displayName == null)
            //         ? const Text("")
            //         : Text("${user.displayName}"),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((user!.isAnonymous)
                    ? ""
                    : (user?.displayName == null)
                        ? ""
                        : "Name: "),
                // const Text("Name :"),
                Text(
                  (user!.isAnonymous)
                      ? ""
                      : (user?.displayName == null)
                          ? ""
                          : FireBaseAuthHelper.firebaseAuth.currentUser?.email
                              ?.split('@')[0] as String,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((user!.isAnonymous) ? "" : "E-mail: "),
                Text((user!.isAnonymous) ? "" : "${user!.email}")
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            (user!.isAnonymous)
                ? const ListTile()
                : ListTile(
                    onTap: () {
                      Get.toNamed('/update_emailpage');
                    },
                    title: const Text(
                      "Update E-mail",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.email_outlined),
                  ),
            (user!.isAnonymous)
                ? const ListTile()
                : ListTile(
                    onTap: () {
                      Get.toNamed('/update_passwordpage');
                    },
                    title: const Text(
                      "Update Password",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.password),
                  ),
            (user!.isAnonymous)
                ? const ListTile()
                : ListTile(
                    onTap: () {
                      Get.toNamed('/delete_accountpage');
                    },
                    title: const Text(
                      "Delete Account",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.delete),
                  ),
            ListTile(
              title: const Text(
                "Theme Mode",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Switch(
                value: themeController.darkModeModel.isdark,
                onChanged: (val) {
                  setState(() {
                    themeController.darkThemeUDF(val: val);
                  });
                  // Get.changeTheme(Get.isDarkMode
                  //     ? ThemeData.light()
                  //     : ThemeData.dark());
                  print("2");
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Voter App"),
        actions: [
          IconButton(
            onPressed: () async {
              await FireBaseAuthHelper.fireBaseAuthHelper.signOut();

              Get.offNamed('/login_page');
              logINOutController.logInOutTrueValue();
            },
            icon: const Icon(CupertinoIcons.power),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            "LIVE VOTE",
            style:
               TextStyle(fontSize: 30,fontWeight: FontWeight.w500)
          ),
          const SizedBox(
            height: 40,
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FireStoreHelper.fireStoreHelper.fetchAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Text("ERROR:${snapshot.hasError}");
                } else if (snapshot.hasData) {
                  QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;

                  List allDocs = (data == null) ? [] : data.docs;
                  // List allDocs = (data == null) ? [] : data.docs;
                  print(allDocs);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: allDocs.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 90,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.black12, width: 2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "BJP :",
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " ${allDocs[i]['bjp']}",
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    height: 90,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.black12, width: 2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CONGRESS :",
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " ${allDocs[i]['congress']}",
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 90,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.black12, width: 2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "AAP :",
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " ${allDocs[i]['aap']}",
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    height: 90,
                                    width: 145,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.black12, width: 2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "OTHERS :",
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          " ${allDocs[i]['others']}",
                                          style: GoogleFonts.aBeeZee(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: const Text("Vote For Any One"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      await FireStoreHelper.fireStoreHelper.voteForBjp();

                      FireStoreHelper.fireStoreHelper.voteValueTrueOrFalse();
                      Get.back();
                    },
                    child: const Text("BJP PARTY"),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      await FireStoreHelper.fireStoreHelper.voteForCongress();
                      FireStoreHelper.fireStoreHelper.voteValueTrueOrFalse();

                      Get.back();
                    },
                    child: const Text("CONGRESS PARTY"),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      await FireStoreHelper.fireStoreHelper.voteForAap();
                      FireStoreHelper.fireStoreHelper.voteValueTrueOrFalse();

                      Get.back();
                    },
                    child: const Text("AAP PARTY"),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      await FireStoreHelper.fireStoreHelper.voteForOthers();
                      FireStoreHelper.fireStoreHelper.voteValueTrueOrFalse();

                      Get.back();
                    },
                    child: const Text("OTHERS PARTY"),
                  ),
                ],
              ),
              // actions: [
              //   Column(
              //     children: [
              //       ElevatedButton.icon(
              //         onPressed: () {},
              //           label: Text("BJP"),
              //         icon: Icon(),
              //       ),
              //     ],
              //   )
              // ],
            ),
          );
        },
        child: const Icon(Icons.recommend_rounded),
      ),
    );
  }

  insertUser() {
    Get.dialog(
      AlertDialog(
        title: const Center(
          child: Text("Add User"),
        ),
        content: Form(
          key: adduserformkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                validator: (val) {
                  return (val!.isEmpty) ? "Please enter name.." : null;
                },
                decoration: const InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: ageController,
                validator: (val) {
                  return (val!.isEmpty) ? "Please enter age.." : null;
                },
                decoration: const InputDecoration(
                  hintText: "Age",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (adduserformkey.currentState!.validate()) {
                adduserformkey.currentState!.save();

                Get.back();

                // String? token = await FCMHelper.fcmHelper.getDeviceToken();

                // FireStoreHelper.fireStoreHelper.insertUserWhileSignIn(data: {
                //   "name": nameController.text,
                //   "age": ageController.text,
                //   "email": user!.email,
                // });

                // FireStoreHelper.fireStoreHelper.addUser(data: {
                //   "name": nameController.text,
                //     "age": ageController.text,
                //     "email": user!.email,
                // });

                Get.showSnackbar(
                  const GetSnackBar(
                    message: "SUCCESSFULLY ADD USER",
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
                nameController.clear();
                ageController.clear();
              }
            },
            child: const Text("ADD USER"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              nameController.clear();
              ageController.clear();
            },
            child: const Text("CANCEL"),
          ),
        ],
      ),
    );
  }
}
