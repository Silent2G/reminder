import 'package:flutter/material.dart';

class DialogWrap extends StatelessWidget {
  final Widget? child;
  final double? borderRadius;
  final double? height;

  const DialogWrap({
    Key? key,
    required this.child,
    this.borderRadius,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 20),
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: SizedBox(
          height: height ?? 500,
          child: child,
        ),
      ),
    );
  }
}
