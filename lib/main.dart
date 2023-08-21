import 'package:advance_viva2_voting_app/utills/apptheme_utills.dart';
import 'package:advance_viva2_voting_app/views/screens/home_page.dart';
import 'package:advance_viva2_voting_app/views/screens/information_page.dart';
import 'package:advance_viva2_voting_app/views/screens/login_page.dart';
import 'package:advance_viva2_voting_app/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

void main() async {
  GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      theme: AppTheme.lighttheme,
      darkTheme: AppTheme.darktheme,
      themeMode: ThemeMode.system,
      initialRoute: 'splash_screen',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const Home_page()),
        GetPage(name: '/login_page', page: () => const Login_page()),
        GetPage(name: '/information_page', page: () => const Information_page()),
        GetPage(name: '/splash_screen', page: () => const Splash_screen()),
      ],
    ),
  );
}
