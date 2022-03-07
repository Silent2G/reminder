import 'package:flutter/material.dart';

import '../../dialogs/add_user_dialog/components/status_selector.dart';

class UserDialogProvider with ChangeNotifier {
  TextEditingController numberController = TextEditingController(text: '');
  TextEditingController hoursController = TextEditingController(text: '');

  String? soldierNumber;
  SoldierStatus? soldierStatus = SoldierStatus.none;
  int? soldierHours;
  DateTime? startDutyTime;

  void clearField() {
    numberController.text = '';
    isFieldEmpty = true;
    notifyListeners();
  }

  void changeSoldierStatus(SoldierStatus? status) {
    soldierStatus = status;
    notifyListeners();
  }

  void setStartHour(TimeOfDay timeOfDay) {
    final DateTime now = DateTime.now();
    startDutyTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    notifyListeners();
  }

  bool isFieldEmpty = true;

  Function(String) getOnChangedFunction() {
    return (String value) {
      isFieldEmpty = value.isEmpty;
    };
  }
}
