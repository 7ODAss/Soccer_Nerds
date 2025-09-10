import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final ButtonStyle buttonStyle;
  final TextStyle buttonTextStyle;

  const Button({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.buttonStyle,
    required this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:buttonStyle,
      child: Text(
      buttonText,
      style: buttonTextStyle
    ),
    );
  }
}
