import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/infra/model/task.dart';
import 'package:todo_app/presentation/task_edit/task_edit_view_model.dart';

class TaskEditPage extends HookWidget with WidgetsBindingObserver {
  TaskEditPage(this._task);

  Task _task;
  TaskEditViewModel? _taskEditViewModel;

  @override
  Widget build(BuildContext context) {
    _taskEditViewModel = context.read(taskDetailViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("タスク編集画面"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: _task.title),
              decoration: const InputDecoration(
                hintText: 'タイトルを入力してください',
                labelText: 'タイトル',
              ),
              onChanged: (value) {
                _task = _task.copyWith(title: value);
              },
            ),
            SizedBox(height: 40),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: _task.task),
                decoration: const InputDecoration(
                  hintText: 'タスク詳細を入力してください',
                  labelText: 'タスク詳細',
                ),
                onChanged: (value) {
                  _task = _task.copyWith(task: value);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if (_task.title.isEmpty || _task.task.isEmpty) {
            Fluttertoast.showToast(msg: '空白になっています');
            return;
          }
          if (_task.id == null) {
            _taskEditViewModel?.insertNewTask(_task).then((value) => Navigator.of(context).pop());
          } else {
            _taskEditViewModel?.updateTask(_task).then((value) => Navigator.of(context).pop());
          }
        },
      ),
    );
  }
}
