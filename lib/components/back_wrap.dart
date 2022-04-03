import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackWrap extends StatelessWidget {
  const BackWrap({
    Key? key,
    required this.body,
    this.voidCallback,
  }) : super(key: key);

  final Widget body;
  final VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body,
        Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: SvgPicture.asset("assets/images/svg/back.svg"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (voidCallback != null) {
                    voidCallback!();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
