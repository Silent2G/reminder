import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../pages/user/components/time_soldier_status.dart';

class UserItemProvider with ChangeNotifier {
  TimeSoldierStatus checkDutyStatus(User user) {
    final DateTime now = DateTime.now();
    if (user.onDuty) {
      if (now.isBefore(user.startDutyTime)) {
        return TimeSoldierStatus.waiting;
      }

      if (now.isAfter(user.startDutyTime) && now.isBefore(user.endDutyTime)) {
        return TimeSoldierStatus.onDuty;
      }
      return TimeSoldierStatus.free;
    } else {
      return TimeSoldierStatus.free;
    }
  }

  String getTitleByTimeSoldierStatus(TimeSoldierStatus status) {
    if (status == TimeSoldierStatus.waiting) {
      return "В очікуванні";
    }

    if (status == TimeSoldierStatus.onDuty) {
      return "На чергуванні";
    }

    return "Вільний";
  }

  Color getColorByTimeSoldierStatus(TimeSoldierStatus status) {
    if (status == TimeSoldierStatus.waiting) {
      return Colors.orange.withOpacity(0.8);
    }

    if (status == TimeSoldierStatus.onDuty) {
      return Colors.red.withOpacity(0.6);
    }

    return Colors.green.withOpacity(0.8);
  }

  String calculateSoldierRestTime(User user) {
    final now = DateTime.now();
    final period = now.toUtc().millisecondsSinceEpoch -
        user.endDutyTime.toUtc().millisecondsSinceEpoch;
    final durationPeriod = Duration(milliseconds: period);
    final hours = durationPeriod.inHours;
    if (hours < 1) {
      return "Менше години";
    } else {
      return "$hours год.";
    }
  }
}
