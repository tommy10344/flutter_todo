import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/pages/edit.dart';
import 'package:flutter_todo/utilities.dart';

import './add.dart';
import '../task.dart';
import '../task_list_controller.dart';

class TaskListItem extends StatelessWidget {
  final Key key;
  final Task task;
  final Function(bool) checkChanged;

  TaskListItem(this.key, this.task, this.checkChanged) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: this.key,
      elevation: 2.0,
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            if (value != null) {
              checkChanged(value);
            }
          },
        ),
        title: Text(task.title),
        onTap: () {
          showModal(context, (_) => EditPage(task));
        },
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final taskList = watch(taskListProvider);
    final taskListController = watch(taskListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: ReorderableListView(
        children: taskList.map((task) {
          return TaskListItem(ValueKey(task.id), task, (isChecked) {
            taskListController.setIsDone(task.id, isChecked);
          });
        }).toList(),
        onReorder: (oldIndex, newIndex) {
          taskListController.reorder(oldIndex, newIndex);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(context, (_) => AddPage());
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
