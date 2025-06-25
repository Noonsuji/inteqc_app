import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inteqc_app/states/authen.dart';
import 'package:inteqc_app/utility/app_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String platform;

    if (kIsWeb) {
      platform = 'Web';
    } else if (Platform.isAndroid) {
      platform = 'Android';
    } else if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Other';
    }

    return GetMaterialApp(
      home: Authen(platform: platform), 
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstant.appColor),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
