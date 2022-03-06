import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/state/user_provider.dart';

class MultiProviderSetup extends StatelessWidget {
  const MultiProviderSetup({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: child,
    );
  }
}
