// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:inteqc_app/utility/app_constant.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidthButton,
    this.icon,
    this.borderShape,
  });

  final String text;
  final Function() onPressed;
  final bool? fullWidthButton;
  final Widget? icon;
  final ShapeBorder? borderShape;
  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: text,
      color: AppConstant.appColor,
      fullWidthButton: fullWidthButton,
      icon: icon,
      shape: GFButtonShape.standard,
      borderShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), 
      ),
      textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold, 
  ),
    );
  }
}
