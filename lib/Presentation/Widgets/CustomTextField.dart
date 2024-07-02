import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.validator,
      this.onChanged,
      this.hinttext,
      this.obscureText,
      this.type,
      this.maxLength});
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? hinttext;
  final bool? obscureText;
  final TextInputType? type;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          maxLengthEnforcement: MaxLengthEnforcement.none,
          maxLength: maxLength,
          keyboardType: type,
          obscureText: obscureText!,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              counterText: '',
              hintText: hinttext!,
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50))),
          validator: validator,
          onChanged: onChanged),
    );
  }
}
