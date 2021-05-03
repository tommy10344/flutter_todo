import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        child: CheckboxListTile(
      title: Text(task.title),
      value: task.isCompleted,
      onChanged: (value) {
        if (value != null) {
          checkChanged(value);
        }
      },
    ));
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AddPage();
                  },
                  fullscreenDialog: true));
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
