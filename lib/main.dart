import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_admin/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required for Firebase.initializeApp()
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyCfZymUqRyFncJhMS6HAlCrTTCi4CIVYrE",
              appId: "1:382617883259:web:5cbd94d1aa1fc7be9408de",
              messagingSenderId: "382617883259",
              projectId: "multi-vendor-store-577d2",
              storageBucket: "multi-vendor-store-577d2.appspot.com",
            )
          : null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
