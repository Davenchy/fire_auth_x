import 'package:fire_auth_x/screens/login_screen.dart';
import 'package:fire_auth_x/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FireAuthX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen()),
      ],
    );
  }
}
