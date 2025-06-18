// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AppConstant {
  static Color appColor = Color(0xFFA21D21); //static ประกาศใช้ทั้งแอป
  static Color appColor2 = Color.fromARGB(255, 66, 65, 65); //static ประกาศใช้ทั้งแอป
  static Color appColor3 = Color.fromARGB(0, 250, 250, 250); //static ประกาศใช้ทั้งแอป
  static Color appColorBorderFill = Color.fromARGB(255, 10, 88, 224); //static ประกาศใช้ทั้งแอป
  static Color appColorTitels = Color.fromARGB(255, 255, 255, 255); //static ประกาศใช้ทั้งแอป
  
  static headStyle({double? fontSize, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Kanit',
      color: const Color.fromARGB(255, 71, 71, 71)
    );
  }
  static TextStyle bodyStyle() => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    fontFamily: 'Kanit',
  );

  static TxtStyle({double? fontSize, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Kanit',
      color: color
    );
  }

  static LoginStyle({double? fontSize, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
      color: color
    );
  }
}
