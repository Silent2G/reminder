import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder/constants.dart';
import 'package:reminder/models/users_holder.dart';

import '../models/user.dart';

class UserRepository {
  Future<List<User>> getAllUsers() async {
    final box = await Hive.openBox(Constants.boxKey);

    final UsersHolder result = box.get(Constants.usersHolderKey);

    return result.users;
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

  Future<void> addUserToDb(User user) async {
    final box = await Hive.openBox(Constants.boxKey);
    final UsersHolder holder = box.get(Constants.usersHolderKey);

    holder.users.add(user);

    box.put(Constants.usersHolderKey, user);
  }

  Future<void> updateUser(User value) async {
    final User? user = await getUserById(value.id);

    if (user != null) {
      user.copyWith(
        id: value.id,
        title: value.title,
        onDuty: value.onDuty,
        startDutyTime: value.startDutyTime,
        endDutyTime: value.endDutyTime,
        allDutyHours: value.allDutyHours,
        lastDutyPeriod: value.lastDutyPeriod,
      );
      user.save();
    }
  }
}
