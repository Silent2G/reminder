// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersHolderAdapter extends TypeAdapter<UsersHolder> {
  @override
  final int typeId = 2;

  @override
  UsersHolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersHolder(
      users: (fields[0] as List).cast<User>(),
    );
  }

  @override
  void write(BinaryWriter writer, UsersHolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.users);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersHolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
