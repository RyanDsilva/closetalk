// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  String title;
  bool isCompleted;

  Task({
    required this.title,
    required this.isCompleted,
  });

  Task copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Task(title: $title, isCompleted: $isCompleted)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.title == title && other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => title.hashCode ^ isCompleted.hashCode;
}
