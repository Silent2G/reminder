import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder/constants.dart';
import 'package:reminder/models/users_holder.dart';

import '../models/user.dart';
import '../pages/user/components/time_soldier_status.dart';

class UserRepository {
  Future<List<User>> getAllUsers() async {
    final box = await Hive.openBox(Constants.boxKey);

    final UsersHolder result =
        box.get(Constants.usersHolderKey, defaultValue: UsersHolder(users: []));

    return result.users;
  }

  Future<List<User>> getSortedUsers() async {
    final users = await getAllUsers();
    final List<User> timedUsers = [];

    for (final User item in users) {
      final status = checkDutyStatus(item);
      item.status = status;
      timedUsers.add(item);
    }

    final List<User> sortedUsers = [];

    final free =
        getUsersByTimeSolidersStatus(timedUsers, TimeSoldierStatus.free);
    final waiting =
        getUsersByTimeSolidersStatus(timedUsers, TimeSoldierStatus.waiting);
    final onDuty =
        getUsersByTimeSolidersStatus(timedUsers, TimeSoldierStatus.onDuty);

    sortedUsers.addAll(free);
    sortedUsers.addAll(waiting);
    sortedUsers.addAll(onDuty);

    return sortedUsers;
  }

  Future<List<User>> getStatisticSortedUsers() async {
    final users = await getAllUsers();
    users.sort((a, b) => b.allDutyHours.compareTo(a.allDutyHours));

    return users;
  }

  List<User> getUsersByTimeSolidersStatus(
      List<User> users, TimeSoldierStatus status) {
    List<User> result = [];

    for (final User item in users) {
      if (item.status == status) {
        result.add(item);
      }
    }

    result.sort((a, b) => a.endDutyTime.compareTo(b.endDutyTime));

    return result;
  }

  Future<void> writeAllUsers(List<User> users) async {
    final box = await Hive.openBox(Constants.boxKey);
    box.put(Constants.usersHolderKey, UsersHolder(users: users));
  }

  Future<User?> getUserById(int id) async {
    final box = await Hive.openBox(Constants.boxKey);
    final UsersHolder holder = box.get(Constants.usersHolderKey);

    User? result;

    for (final User user in holder.users) {
      if (user.id == id) {
        result = user;
      }
    }

    return result;
  }

  Future<void> deleteUserFromDB(User user) async {
    final box = await Hive.openBox(Constants.boxKey);
    final UsersHolder holder = box.get(Constants.usersHolderKey);

    for (final User item in holder.users) {
      if (user.id == item.id) {
        holder.users.remove(item);
        break;
      }
    }

    holder.save();
  }

  Future<void> addUserToDb(User user) async {
    final box = await Hive.openBox(Constants.boxKey);
    final UsersHolder holder =
        box.get(Constants.usersHolderKey, defaultValue: UsersHolder(users: []));

    holder.users.add(user);
    holder.save();
  }

  Future<void> updateUser() async {
    final box = await Hive.openBox(Constants.boxKey);
    final UsersHolder holder =
        box.get(Constants.usersHolderKey, defaultValue: UsersHolder(users: []));
    holder.save();
  }

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
}
