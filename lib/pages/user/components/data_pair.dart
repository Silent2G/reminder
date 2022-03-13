import 'package:flutter/material.dart';

class DataPair extends StatelessWidget {
  const DataPair({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
