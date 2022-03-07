import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/core/state/user_page_provider.dart';
import 'package:reminder/dialogs/add_user_dialog/add_user_gialog.dart';
import 'package:reminder/pages/user/components/user_item.dart';

import '../../core/state/user_dialog_provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  _UserPageState createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserPageProvider>(
      builder: (_, notifier, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Список бійців"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 35,
                ),
                tooltip: 'Додати бійця',
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => UserDialogProvider(),
                      child: const AddUserDialog(),
                    ),
                    // builder: (BuildContext context) => const AddUserDialog(),
                  );
                },
              ),
            ],
          ),
          body: notifier.users.isNotEmpty
              ? ListView.builder(
                  itemCount: notifier.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UserItem(
                      user: notifier.users[index],
                    );
                  })
              : const Center(
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Будь ласка, додайте бійця (натисніть на плюсик вверху)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
        );
      },
    );
  }
}
