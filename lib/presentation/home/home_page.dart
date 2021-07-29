import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/infra/model/task.dart';
import 'package:todo_app/presentation/home/home_view_model.dart';
import 'package:todo_app/presentation/home/task_item.dart';
import 'package:todo_app/presentation/task_edit/task_edit_page.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(homeViewModelNotifierProvider);

    useEffect(() {
      viewModel.fetchTaskList();
      return viewModel.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text("タスクリスト画面"),
      ),
      body: viewModel.taskList == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.taskList!.length,
              itemBuilder: (context, index) {
                return TaskItem((task) => openTaskEditPage(context, viewModel, task), viewModel, index);
              },
            ),
      floatingActionButton: HookBuilder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              openTaskEditPage(context, viewModel, Task());
            },
          );
        },
      ),
    );
  }

  void openTaskEditPage(BuildContext context, HomeViewModel viewModel, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskEditPage(task)),
    ).then((value) {
      viewModel.fetchTaskList();
    });
  }
}
