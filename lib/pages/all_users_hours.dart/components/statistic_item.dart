import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/user_item_provider.dart';
import '../../../models/user.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
    const fatStyle = TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    final notifier = context.read<UserItemProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Container(
        color: notifier.getColorByTimeSoldierStatus(user.status!),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    user.title,
                    style: fatStyle,
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: Text(
                    user.allDutyHours.toString(),
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: Text(
                    user.dutyCounter.toString(),
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
