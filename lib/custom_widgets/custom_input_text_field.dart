import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Color textColor;
  final String hintText;
  final Color hintTextColor;
  final double hintTextSize;
  final TextEditingController control;
  final TextInputType inputType;
  final Color cursorColor;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Icon icon;
  final Color iconColor;

  const CustomTextField(
  {super.key,
    required this.control,
    required this.hintText,
    this.textColor = Colors.white,
    this.hintTextColor = Colors.white,
    this.hintTextSize = 20,
    this.inputType = TextInputType.number,
    this.cursorColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderRadius = 20,
    this.borderWidth = 1,
    this.enabledBorderColor = Colors.white,
    this.focusedBorderColor = Colors.green,
    this.focusedBorderWidth = 2,
    required this.icon,
    this.iconColor = Colors.white,
});


  @override
  Widget build(BuildContext context) {
    return TextField(
        style: TextStyle(color: textColor),
        controller: control,
        keyboardType:inputType, cursorColor: cursorColor,
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: iconColor,
          labelText: hintText,
          labelStyle: TextStyle(color: hintTextColor, fontSize: hintTextSize),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: focusedBorderWidth,
              color: focusedBorderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: borderWidth,
              color: enabledBorderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        )
    );
  }
}




