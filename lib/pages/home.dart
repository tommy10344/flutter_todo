import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/pages/edit.dart';
import 'package:flutter_todo/utilities.dart';

import './add.dart';
import '../task.dart';
import '../task_list_controller.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final Function(bool) checkChanged;

  TaskListItem(this.task, this.checkChanged);

  @override
  Widget build(BuildContext context) {
    return Card(
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
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text("TODO"),
          leading: TextButton(
            onPressed: () {
              print("Edit");
            },
            child: Text("Edit"),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            var task = taskList[index];
            return TaskListItem(task, (isChecked) {
              taskListController.setIsDone(task.id, isChecked);
            });
          }, childCount: taskList.length),
        ),
      ]),
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
