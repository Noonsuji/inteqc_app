import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inteqc_app/states/authen.dart';
import 'package:inteqc_app/utility/app_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Authen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstant.appColor),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
