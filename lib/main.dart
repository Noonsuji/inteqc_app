import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inteqc_app/states/authen.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:inteqc_app/utility/app_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String platform;

    if (GetPlatform.isWeb) {
      platform = 'Web';
    } else if (GetPlatform.isAndroid) {
      platform = 'Android';
    } else if (GetPlatform.isIOS) {
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
