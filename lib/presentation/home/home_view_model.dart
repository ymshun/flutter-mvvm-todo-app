import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/infra/model/task.dart';
import 'package:todo_app/infra/repository/task_repository.dart';
import 'package:todo_app/infra/repository/task_repositoryImpl.dart';

final homeViewModelNotifierProvider = ChangeNotifierProvider((ref) => HomeViewModel(ref.read(taskRepositoryProvider)));

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._taskRepository);

  final TaskRepository _taskRepository;

  List<Task>? _taskList;

  List<Task>? get taskList => _taskList;

  /// タスクリストをDBから取得
  Future<void> fetchTaskList() {
    debugPrint("fetching taskList...");
    return _taskRepository.getAllTasks().then((value) {
      _taskList = value;
      debugPrint("succeeded fetch: $_taskList");
    }).catchError((error) {
      debugPrint('failed to fetch task list: ${error.toString()}');
    }).whenComplete(notifyListeners);
  }

  /// タスクのcompleted update
  void onCompletedTask(int index, bool isCompleted) {
    Task updatedTask = _taskList![index].copyWith(completed: isCompleted ? 1 : 0);
    _taskRepository.updateTask(updatedTask).catchError((error) {}).whenComplete(() {
      _taskList![index] = updatedTask;
      notifyListeners();
    });
  }
}
