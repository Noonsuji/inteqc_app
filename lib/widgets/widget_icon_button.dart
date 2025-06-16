// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:inteqc_app/utility/app_constant.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  final IconData icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GFIconButton(icon: Icon(icon), onPressed:onPressed,type: GFButtonType.transparent,color: AppConstant.appColor2,);
  }
}
