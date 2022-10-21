import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app/ui/HomePage.dart';

import 'helper/PreferenceHelper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
