import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/core/state/user_dialog_provider.dart';
import 'package:reminder/dialogs/add_duty_dialog/add_duty_dialog.dart';
import 'package:reminder/hive/user_repository.dart';

import '../../../components/color_button.dart';
import '../../../core/state/user_item_provider.dart';
import '../../../models/user.dart';
import 'data_pair.dart';

class UserItemFree extends StatelessWidget {
  const UserItemFree({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<UserItemProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Container(
        decoration: BoxDecoration(color: Colors.green.withOpacity(0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataPair(
                title: "Номер бійця:",
                value: user.title,
              ),
              const DataPair(
                title: "Статус бійця:",
                value: "Вільний",
              ),
              DataPair(
                title: "Кількісь змін:",
                value: user.dutyCounter.toString(),
              ),
              DataPair(
                  title: "Боєць відпочиває:",
                  value: notifier.calculateSoldierRestTime(user)),
              user.lastDutyPeriod > 0
                  ? DataPair(
                      title: "Тривалість останнього чергування:",
                      value: "${user.lastDutyPeriod} год")
                  : Container(),
              Row(
                children: [
                  Expanded(
                    child: ColorButton(
                      title: "Видалити",
                      color: Colors.blue,
                      function: () async {
                        await UserRepository().deleteUserFromDB(user);
                        context.read<UserDialogProvider>().getUsers();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ColorButton(
                      title: "Додати",
                      color: Colors.blue,
                      function: () async {
                        await showDialog<void>(
                          context: context,
                          builder: (_) => ChangeNotifierProvider.value(
                            value: context.read<UserDialogProvider>(),
                            child: AddDutyDialog(user: user),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
