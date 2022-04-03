import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/user_dialog_provider.dart';
import 'components/header.dart';
import 'components/statistic_item.dart';

class AllUsersHoursPage extends StatefulWidget {
  const AllUsersHoursPage({Key? key}) : super(key: key);

  @override
  _AllUsersHoursPage createState() {
    return _AllUsersHoursPage();
  }
}

class _AllUsersHoursPage extends State<AllUsersHoursPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDialogProvider>(builder: (_, notifier, __) {
      return Scaffold(
        appBar: AppBar(
          title: const Header(),
          titleSpacing: 15,
        ),
        body: notifier.usersStatistic.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: notifier.usersStatistic.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StatisticItem(
                              user: notifier.usersStatistic[index]);
                        }),
                  )
                ],
              )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Додайте бійця на вкладці Бійці",
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
    });
  }
}
