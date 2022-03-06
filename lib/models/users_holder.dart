import 'package:hive/hive.dart';
import 'package:reminder/models/user.dart';

part 'users_holder.g.dart';

@HiveType(typeId: 2)
class UsersHolder extends HiveObject {
  UsersHolder({required this.users});

  @HiveField(0)
  List<User> users;
}
