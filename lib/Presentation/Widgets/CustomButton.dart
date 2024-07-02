import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.onPressed,
      this.text,
      this.color,
      this.textColor,
      this.bordercolor});
  final VoidCallback? onPressed;
  final String? text;
  final Color? color;
  final Color? textColor;
  final Color? bordercolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: bordercolor!)),
          color: color,
          child: Text(
            text!,
            style: TextStyle(color: textColor),
          )),
    );
  }
}
