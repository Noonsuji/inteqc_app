// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetTextButton extends StatelessWidget {
  const WidgetTextButton({
    super.key,
    this.onPressed,
    required this.child,
    this.style,
  });

  final Function()? onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: child,
      );
  }
}
