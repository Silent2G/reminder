// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      title: fields[1] as String,
      onDuty: fields[2] as bool,
      startDutyTime: fields[3] as DateTime,
      endDutyTime: fields[4] as DateTime,
      allDutyHours: fields[5] as int,
      lastDutyPeriod: fields[6] as int,
      dutyCounter: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.onDuty)
      ..writeByte(3)
      ..write(obj.startDutyTime)
      ..writeByte(4)
      ..write(obj.endDutyTime)
      ..writeByte(5)
      ..write(obj.allDutyHours)
      ..writeByte(6)
      ..write(obj.lastDutyPeriod)
      ..writeByte(7)
      ..write(obj.dutyCounter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
