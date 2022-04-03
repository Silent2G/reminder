import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    return Container(
      color: Colors.blue,
      child: SizedBox(
        height: 80,
        child: Row(
          children: const [
            Expanded(
              child: Text(
                "Номер бійця",
                style: style,
              ),
              flex: 5,
            ),
            Expanded(
              child: Text(
                "Години",
                textAlign: TextAlign.center,
                style: style,
              ),
              flex: 3,
            ),
            Expanded(
              child: Text(
                "Зміни",
                textAlign: TextAlign.center,
                style: style,
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
