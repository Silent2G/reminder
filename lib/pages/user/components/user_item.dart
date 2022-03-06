import 'package:flutter/widgets.dart';

class UserItem extends StatefulWidget {
  const UserItem({
    Key? key,
  }) : super(key: key);

  @override
  _UserItemState createState() {
    return _UserItemState();
  }
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Text("Soldier item");
  }
}
