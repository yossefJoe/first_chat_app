import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  CustomMaterialButton(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.indigo,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
