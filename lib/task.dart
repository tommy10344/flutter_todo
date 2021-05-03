import 'package:flutter/material.dart';

@immutable
class Task {
  final String id;
  final String title;
  final bool isCompleted;

  Task(this.id, this.title, {this.isCompleted = false});

  Task copyWith({String? id, String? title, bool? isCompleted}) =>
      Task(id ?? this.id, title ?? this.title, isCompleted: isCompleted ?? this.isCompleted);

  String toString() => "Task(id: $id, title: $title, isCompleted: $isCompleted)";
}
