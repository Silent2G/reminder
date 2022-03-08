import 'package:flutter/material.dart';
import 'package:reminder/hive/user_repository.dart';
import 'package:reminder/util.dart';

import '../../dialogs/add_user_dialog/components/status_selector.dart';
import '../../models/user.dart';

class UserDialogProvider with ChangeNotifier {
  TextEditingController numberController = TextEditingController(text: '');
  TextEditingController hoursController = TextEditingController(text: '');

  String? soldierNumber;
  SoldierStatus? soldierStatus = SoldierStatus.none;
  int? soldierHours;
  DateTime? startDutyTime;
  DateTime? endDutyTime;

  List<User> users = [];

  void getUsers() async {
    users = await UserRepository().getAllUsers();
    notifyListeners();
  }

  void clearFieldNumber() {
    numberController.text = '';
  }

  void clearFieldHours() {
    hoursController.text = '';
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

  bool validateFields() {
    bool result = false;
    if (soldierStatus == SoldierStatus.free) {
      if (soldierNumber != null) {
        result = true;
      }
    } else if (soldierStatus == SoldierStatus.onDuty) {
      if (soldierNumber != null &&
          soldierStatus != SoldierStatus.none &&
          soldierHours != null &&
          soldierHours! > 0 &&
          startDutyTime != null) {
        result = true;
      }
    }

    return result;
  }

  bool getOnDuty() {
    return soldierStatus == SoldierStatus.onDuty;
  }

  DateTime generateEndDutyTime() {
    return startDutyTime!.add(Duration(hours: soldierHours!));
  }

  Future<void> createUserAndSaveToDb() async {
    if (soldierStatus == SoldierStatus.none) {
      return;
    }

    late User user;

    if (soldierStatus == SoldierStatus.free) {
      user = User(
        id: Util().createRandomId(),
        title: soldierNumber!,
        onDuty: getOnDuty(),
        startDutyTime: DateTime.now(), // ignore data
        endDutyTime: DateTime.now(), // ignore data
        allDutyHours: 0, // ignore data
        lastDutyPeriod: 0, // ignore data
      );
    } else {
      user = User(
        id: Util().createRandomId(),
        title: soldierNumber!,
        onDuty: getOnDuty(),
        startDutyTime: startDutyTime!,
        endDutyTime: generateEndDutyTime(),
        allDutyHours: 0,
        lastDutyPeriod: soldierHours!,
      );
    }

    debugPrint(user.toString());

    await UserRepository().addUserToDb(user);

    // update soldiers list
    users = await UserRepository().getAllUsers();
  }

  void clearVariables() {
    soldierNumber = null;
    soldierStatus = SoldierStatus.none;
    soldierHours = null;
    startDutyTime = null;
    endDutyTime = null;

    clearFieldNumber();
    clearFieldHours();

    notifyListeners();
  }

  Function(String) getOnChangedFunctionNumber() {
    return (String value) {
      soldierNumber = value;
    };
  }

  Function(String) getOnChangedFunctionHours() {
    return (String value) {
      soldierHours = int.tryParse(value);
    };
  }
}
