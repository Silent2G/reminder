import 'package:flutter/material.dart';
import 'package:reminder/hive/db_wrapper.dart';

import 'multi_provider_setup.dart';
import 'pages/user/users_page.dart';

void main() async {
  runApp(
    const DbWrapper(
      child: MultiProviderSetup(child: UserPage()),
    ),
  );
}
