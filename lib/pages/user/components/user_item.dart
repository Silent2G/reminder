import 'package:flutter/widgets.dart';

import '../../../models/user.dart';

class UserItem extends StatefulWidget {
  const UserItem({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _UserItemState createState() {
    return _UserItemState();
  }
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [Text(widget.user.title)],
      ),
    );
  }
}
