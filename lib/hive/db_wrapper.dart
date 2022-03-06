import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder/constants.dart';
import 'package:reminder/models/user.dart';

import '../models/users_holder.dart';

class DbWrapper extends StatelessWidget {
  const DbWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.initFlutter(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          Hive.box(Constants.boxKey);
          Hive.registerAdapter(UserAdapter());
          Hive.registerAdapter(UsersHolderAdapter());
          return child;
        });
  }
}
