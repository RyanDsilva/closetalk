// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:closetalk/models/user.dart';
import 'package:hive/hive.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 2)
class ChatMessage {
  @HiveField(0)
  String? text;

  @HiveField(1)
  String? translation;

  @HiveField(2)
  User? owner;

  ChatMessage({
    this.text,
    this.translation,
    this.owner,
  });

  ChatMessage copyWith({
    String? text,
    String? translation,
    User? owner,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      translation: translation ?? this.translation,
      owner: owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'translation': translation,
      'owner': owner?.toMap(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      text: map['text'] != null ? map['text'] as String : null,
      translation: map['translation'] != null ? map['translation'] as String : null,
      owner: map['owner'] != null ? User.fromMap(map['owner'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(text: $text, translation: $translation, owner: $owner)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;
  
    return 
      other.text == text &&
      other.translation == translation &&
      other.owner == owner;
  }

  @override
  int get hashCode {
    return text.hashCode ^
      translation.hashCode ^
      owner.hashCode;
  }
}
