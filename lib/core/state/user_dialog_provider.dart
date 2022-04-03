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
  bool deleteLastDuty = false;

  List<User> users = [];
  List<User> usersStatistic = [];

  Future<void> getUsers() async {
    users = await UserRepository().getSortedUsers();
    usersStatistic = await UserRepository().getStatisticSortedUsers();
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

  bool validateNewDutyFields() {
    return soldierHours != null && soldierHours! > 0 && startDutyTime != null;
  }

  bool validateFields() {
    bool result = false;
    if (soldierStatus == SoldierStatus.free) {
      if (soldierNumber != null && soldierNumber!.isNotEmpty) {
        result = true;
      }
    } else if (soldierStatus == SoldierStatus.onDuty) {
      if (soldierNumber != null &&
          soldierNumber!.isNotEmpty &&
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

  Future<void> changeLastUsersDutyAndSaveToDb(User user) async {
    if (deleteLastDuty) {
      user.onDuty = false;
      user.startDutyTime = DateTime.now(); // don't know last data
      user.endDutyTime = DateTime.now(); // don't know last data
      user.allDutyHours = user.allDutyHours - user.lastDutyPeriod;
      user.dutyCounter = user.dutyCounter - 1;
      user.lastDutyPeriod = 0; // don't know last data
    } else {
      user.startDutyTime = startDutyTime!;
      user.endDutyTime = generateEndDutyTime();
      user.allDutyHours =
          user.allDutyHours - user.lastDutyPeriod + soldierHours!;
      user.lastDutyPeriod = soldierHours!;
    }

    await UserRepository().updateUser();

    // update soldiers list
    getUsers();
  }

  Future<void> addNewDutyToUserAndSaveToDb(User user) async {
    user.onDuty = true;
    user.startDutyTime = startDutyTime!;
    user.endDutyTime = generateEndDutyTime();
    user.allDutyHours = user.allDutyHours + soldierHours!;
    user.lastDutyPeriod = soldierHours!;
    user.dutyCounter = user.dutyCounter + 1;

    await UserRepository().updateUser();

    // update soldiers list
    getUsers();
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
          dutyCounter: 0);
    } else {
      user = User(
          id: Util().createRandomId(),
          title: soldierNumber!,
          onDuty: getOnDuty(),
          startDutyTime: startDutyTime!,
          endDutyTime: generateEndDutyTime(),
          allDutyHours: soldierHours!,
          lastDutyPeriod: soldierHours!,
          dutyCounter: 1);
    }

    debugPrint(user.toString());

    await UserRepository().addUserToDb(user);

    // update soldiers list
    getUsers();
  }

  void clearVariables() {
    soldierNumber = null;
    soldierStatus = SoldierStatus.none;
    soldierHours = null;
    startDutyTime = null;
    endDutyTime = null;
    deleteLastDuty = false;

    clearFieldNumber();
    clearFieldHours();

    notifyListeners();
  }

  Function(String) getOnChangedFunctionNumber() {
    return (String value) {
      soldierNumber = value;
      notifyListeners();
    };
  }

  Function(String) getOnChangedFunctionHours() {
    return (String value) {
      soldierHours = int.tryParse(value);
      notifyListeners();
    };
  }
}
