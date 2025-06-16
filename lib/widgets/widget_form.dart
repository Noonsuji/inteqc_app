// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:inteqc_app/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    super.key,
    this.hintText,
    this.suffixIcon,
    required this.obscureText,
    this.labelText,
    this.validator,
    this.controller,
  });
  final String? hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: controller,
      validator: validator,
      style: AppConstant.bodyStyle(),
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(
              255,
              43,
              119,
              251,
            ), // ขอบตอนกำลังพิมพ์ (focus)
            width: 2,
          ),
        ),
        border: OutlineInputBorder(),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: AppConstant.appColor3,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 112, 112, 112), // สีของ labelText
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
