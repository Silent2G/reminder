import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool onDuty;

  @HiveField(3)
  DateTime startDutyTime;

  @HiveField(4)
  DateTime endDutyTime;

  @HiveField(5)
  int allDutyHours;

  @HiveField(6)
  int lastDutyPeriod;

  User(
      {required this.id,
      required this.title,
      required this.onDuty,
      required this.startDutyTime,
      required this.endDutyTime,
      required this.allDutyHours,
      required this.lastDutyPeriod});

  User copyWith({
    int? id,
    String? title,
    bool? onDuty,
    DateTime? startDutyTime,
    DateTime? endDutyTime,
    int? allDutyHours,
    int? lastDutyPeriod,
  }) {
    return User(
      id: this.id,
      title: title ?? this.title,
      onDuty: onDuty ?? this.onDuty,
      startDutyTime: startDutyTime ?? this.startDutyTime,
      endDutyTime: endDutyTime ?? this.endDutyTime,
      allDutyHours: allDutyHours ?? this.allDutyHours,
      lastDutyPeriod: lastDutyPeriod ?? this.lastDutyPeriod,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, title: $title, onDuty: $onDuty, startDutyTime: $startDutyTime, endDutyTime: $endDutyTime, allDutyHours: $allDutyHours, lastDutyPeriod: $lastDutyPeriod}';
  }
}
