// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
enum Status {
  @HiveField(0)
  connected,
  @HiveField(1)
  disconnected
}

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? avatar;

  @HiveField(3)
  String? introduction;

  @HiveField(4)
  String? language;

  // @HiveField(5, defaultValue: Status.disconnected)
  // Status? status;

  User({
    this.id,
    this.name,
    this.avatar,
    this.introduction,
    this.language,
    // this.status,
  });

  User copyWith({
    String? id,
    String? name,
    String? avatar,
    String? introduction,
    String? language,
    Status? status,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      introduction: introduction ?? this.introduction,
      language: language ?? this.language,
      // status: status ?? this.status,
    );
  }

  // static Status _getStatusFromString(String statusString) {
  //   return statusString == 'Status.connected'
  //       ? Status.connected
  //       : Status.disconnected;
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
      'introduction': introduction,
      'language': language,
      // 'status': status.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      introduction:
          map['introduction'] != null ? map['introduction'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      // status: _getStatusFromString(map['status'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, avatar: $avatar, introduction: $introduction, language: $language)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.avatar == avatar &&
        other.introduction == introduction &&
        other.language == language;
    // other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        introduction.hashCode ^
        language.hashCode;
    // status.hashCode;
  }
}
