import 'package:advance_viva2_voting_app/views/screens/home_page.dart';
import 'package:advance_viva2_voting_app/views/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

void main() async{
  GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData(useMaterial3: true),
      initialRoute: 'login_page',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const Home_page()),
        GetPage(name: '/login_page', page: () => const Login_page()),
      ],
    ),
  );
}
