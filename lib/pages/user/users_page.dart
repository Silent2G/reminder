import 'package:flutter/material.dart';
import 'package:reminder/pages/user/components/user_item.dart';

class UserPage extends StatelessWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return const UserItem();
      }),
    );
  }
}