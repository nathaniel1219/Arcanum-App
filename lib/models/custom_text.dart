import 'package:flutter/material.dart';

class widgetTest extends StatelessWidget {
  const widgetTest({
    super.key,
    required this.peachColor,
    required this.buttonFont,
  });

  final Color peachColor;
  final double buttonFont;

  @override
  Widget build(BuildContext context) {
    return Text(
      'View',
      style: TextStyle(
        color: peachColor,
        fontSize: buttonFont,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}