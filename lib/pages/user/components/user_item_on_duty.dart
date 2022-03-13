import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/color_button.dart';
import '../../../core/state/user_dialog_provider.dart';
import '../../../hive/user_repository.dart';
import '../../../models/user.dart';
import 'data_pair.dart';

class UserItemOnDuty extends StatelessWidget {
  const UserItemOnDuty({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Container(
        decoration: BoxDecoration(color: Colors.red.withOpacity(0.6)),
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
                value: "На чергуванні",
              ),
              DataPair(
                title: "Кількість годин чергування:",
                value: user.lastDutyPeriod.toString(),
              ),
              DataPair(
                title: "Година початку чергування сьогодні:",
                value:
                    DateFormat('yyyy-MM-dd – kk:mm').format(user.startDutyTime),
              ),
              DataPair(
                title: "Година закінчення чергування:",
                value:
                    DateFormat('yyyy-MM-dd – kk:mm').format(user.endDutyTime),
              ),
              ColorButton(
                title: "Видалити",
                color: Colors.blue,
                function: () async {
                  await UserRepository().deleteUserFromDB(user);
                  context.read<UserDialogProvider>().getUsers();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
