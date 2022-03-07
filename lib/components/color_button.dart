import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final String title;
  final Function()? function;
  final Color? color;
  final double? borderRadius;
  final double? width;
  final double? fontSize;

  const ColorButton({
    Key? key,
    required this.title,
    required this.function,
    this.color,
    this.borderRadius,
    this.width,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          primary: color ?? Colors.white.withOpacity(0.5),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              borderRadius == null
                  ? const Radius.circular(4)
                  : Radius.circular(borderRadius!),
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          child: Text(
            title,
            style: TextStyle(
                fontSize: fontSize ?? 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
