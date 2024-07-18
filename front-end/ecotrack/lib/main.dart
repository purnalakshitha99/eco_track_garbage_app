import 'package:ecotrack/Components/MyBottomNavigationBar.dart';
import 'package:ecotrack/screen/Admin/adminHomePage.dart';
import 'package:ecotrack/screen/TruckDriver/TruckDriverHomePage.dart';
import 'package:ecotrack/screen/User/firstPage.dart';
import 'package:ecotrack/screen/User/signInPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage()
    );
  }
}