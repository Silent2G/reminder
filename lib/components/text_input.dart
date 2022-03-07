import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  final TextEditingController controller;
  final bool? enabled;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  const AppTextInput({
    Key? key,
    required this.controller,
    this.enabled,
    this.decoration,
    this.textStyle,
    this.onChanged,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      style: textStyle ??
          const TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
      textAlign: TextAlign.left,
      // cursorColor: Colors.white,
      decoration: decoration ??
          const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none),
    );
  }
}
