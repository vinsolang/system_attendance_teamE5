import 'package:attence_system/page/home.dart';
import 'package:attence_system/page/welcome.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");

    if (email != null) {
      return HomeScreen(userEmail: email); // already logged in
    } else {
      return WelcomeScreen(); // not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      home: FutureBuilder(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data!;
        },
      ),
    );
  }
}