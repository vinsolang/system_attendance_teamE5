
import 'package:attence_system/page/welcome.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
void main() {
  runApp(
    DevicePreview(
      enabled: true, // turn off in production
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: WelcomeScreen(),
    );
  }
}
