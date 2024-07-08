// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:month_project/Auth/auth.dart';
import 'package:month_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  // Call the permission request method
  requestStoragePermission();
}

void requestStoragePermission() async {
  // Check if the platform is not web, as web has no permissions
  // Request camera permission
  var cameraStatus = await Permission.camera.status;
  if (!cameraStatus.isGranted) {
    await Permission.camera.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
