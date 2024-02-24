// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:closetalk/models/chat_message.dart';
import 'package:closetalk/models/user.dart';
import 'package:hive/hive.dart';

part 'group_chat.g.dart';

@HiveType(typeId: 4)
class GroupChat {
  @HiveField(0)
  List<ChatMessage>? messages;

  @HiveField(1)
  User? user;

  GroupChat({
    this.messages,
    this.user,
  });

  GroupChat copyWith({
    List<ChatMessage>? messages,
    User? user,
  }) {
    return GroupChat(
      messages: messages ?? this.messages,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messages': messages?.map((x) => x.toMap()).toList(),
      'user': user?.toMap(),
    };
  }

  factory GroupChat.fromMap(Map<String, dynamic> map) {
    return GroupChat(
      messages: map['messages'] != null ? List<ChatMessage>.from((map['messages'] as List<int>).map<ChatMessage?>((x) => ChatMessage.fromMap(x as Map<String,dynamic>),),) : null,
      user: map['user'] != null ? User.fromMap(map['user'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupChat.fromJson(String source) => GroupChat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Chat(messages: $messages, user: $user)';

  @override
  bool operator ==(covariant GroupChat other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.messages, messages) &&
      other.user == user;
  }

  @override
  int get hashCode => messages.hashCode ^ user.hashCode;
}
