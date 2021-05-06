import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import './task.dart';

class TaskListController extends StateNotifier<List<Task>> {
  TaskListController(List<Task>? initialTasks) : super(initialTasks ?? []);

  int get length => state.length;

  Task get(int index) {
    return state[index];
  }

  void add(String title) {
    final task = Task(Uuid().v4(), title);
    state = [...state, task];
  }

  void update(Task newTask) {
    state = state.map((task) {
      if (newTask.id == task.id) {
        return newTask;
      } else {
        return task;
      }
    }).toList();
  }

  void delete(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  void deleteAll() {
    state = [];
  }

  void setIsDone(String id, bool isCompleted) {
    print("before --- $state");
    state = state.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: isCompleted);
      } else {
        return task;
      }
    }).toList();
    print("after --- $state");
  }
}

final taskListProvider = StateNotifierProvider((ref) => TaskListController([
      Task(Uuid().v4(), "task1"),
      Task(Uuid().v4(), "task2"),
      Task(Uuid().v4(), "task3"),
    ]));
