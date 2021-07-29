import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      Fluttertoast.showToast(msg: 'エラーが発生しました');
      debugPrint('failed to fetch task list: ${error.toString()}');
    }).whenComplete(notifyListeners);
  }

  /// タスクのcompleted update
  Future<void> onCompletedTask(int index, bool isCompleted) {
    Task updatedTask = _taskList![index].copyWith(completed: isCompleted ? 1 : 0);
    return _taskRepository.updateTask(updatedTask).catchError((error) {
      Fluttertoast.showToast(msg: 'エラーが発生しました');
      debugPrint('failed to update task: ${error.toString()}');
    }).whenComplete(() {
      _taskList![index] = updatedTask;
      notifyListeners();
    });
  }

  Future<void> deleteTask(int index) {
    return _taskRepository.deleteTask(_taskList![index].id!).catchError((error) {
      Fluttertoast.showToast(msg: 'エラーが発生しました');
      debugPrint('failed to delete task: ${error.toString()}');
    }).whenComplete(() {
      _taskList!.removeAt(index);
      notifyListeners();
    });
  }
}
