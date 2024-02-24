// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupChatAdapter extends TypeAdapter<GroupChat> {
  @override
  final int typeId = 4;

  @override
  GroupChat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupChat(
      messages: (fields[0] as List?)?.cast<ChatMessage>(),
      user: fields[1] as User?,
    );
  }

  @override
  void write(BinaryWriter writer, GroupChat obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.messages)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
