import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/task.dart';
import 'package:flutter_todo/task_list_controller.dart';

class EditPage extends ConsumerWidget {
  final Task task;

  final taskNameController = TextEditingController();

  EditPage(this.task) {
    taskNameController.text = task.title;;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final taskListController = watch(taskListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("タスクを編集"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
                child: TextField(
              controller: taskNameController,
              decoration: InputDecoration(hintText: "タイトル"),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  child: Text("完了"),
                  onPressed: () {
                    final title = taskNameController.text;
                    taskListController.update(task.copyWith(title: title));
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
