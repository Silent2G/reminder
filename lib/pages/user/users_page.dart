import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/dialogs/add_user_dialog/add_user_gialog.dart';
import 'package:reminder/pages/user/components/user_item_free.dart';
import 'package:reminder/pages/user/components/user_item_on_duty.dart';
import 'package:reminder/pages/user/components/user_item_waiting.dart';

import '../../core/state/user_dialog_provider.dart';
import '../../models/user.dart';
import 'components/time_soldier_status.dart';

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
  late UserDialogProvider userDialogNotifier;

  @override
  void initState() {
    userDialogNotifier = context.read<UserDialogProvider>();
    userDialogNotifier.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDialogProvider>(
      builder: (_, notifier, __) {
        return Scaffold(
          floatingActionButton: notifier.users.isNotEmpty
              ? FloatingActionButton(
                  child: const Icon(Icons.update),
                  tooltip: "Оновити дані",
                  onPressed: () async {
                    await userDialogNotifier.getUsers();
                  },
                )
              : null,
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
                    builder: (_) => ChangeNotifierProvider.value(
                      value: userDialogNotifier,
                      child: const AddUserDialog(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: notifier.users.isNotEmpty
              ? ListView.builder(
                  itemCount: notifier.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getWidgetByTimeSoldierStatus(notifier.users[index]);
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
                  ),
                ),
        );
      },
    );
  }

  Widget getWidgetByTimeSoldierStatus(User user) {
    switch (user.status) {
      case TimeSoldierStatus.onDuty:
        return UserItemOnDuty(user: user);
      case TimeSoldierStatus.waiting:
        return UserItemWaiting(user: user);
      case TimeSoldierStatus.free:
        return UserItemFree(user: user);

      default:
        return Container();
    }
  }
}
