import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  final TextEditingController controller;
  final bool? enabled;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? initialValue;

  const AppTextInput({
    Key? key,
    required this.controller,
    this.enabled,
    this.decoration,
    this.textStyle,
    this.onChanged,
    this.keyboardType,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled ?? false,
      initialValue: initialValue,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      style: textStyle ??
          const TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
      textAlign: TextAlign.left,
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
