import 'package:flutter/material.dart';
import 'package:reminder/hive/user_repository.dart';

import '../../models/user.dart';

class UserPageProvider with ChangeNotifier {
  List<User> users = [];

  void getUsers() async {
    users = await UserRepository().getAllUsers();
    notifyListeners();
  }
}
