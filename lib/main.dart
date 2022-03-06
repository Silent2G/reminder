import 'package:flutter/material.dart';
import 'package:reminder/hive/db_wrapper.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/user.dart';
import '../models/users_holder.dart';

import 'multi_provider_setup.dart';
import 'pages/user/users_page.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UsersHolderAdapter());

  runApp(
    const MaterialApp(
      home: MultiProviderSetup(
        child: UserPage(),
      ),
    ),
  );
}
