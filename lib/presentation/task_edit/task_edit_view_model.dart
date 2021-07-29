import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/infra/model/task.dart';
import 'package:todo_app/infra/repository/task_repository.dart';
import 'package:todo_app/infra/repository/task_repositoryImpl.dart';
import 'package:uuid/uuid.dart';

final taskDetailViewModelProvider = ChangeNotifierProvider((ref) => TaskEditViewModel(ref.read(taskRepositoryProvider)));

class TaskEditViewModel extends ChangeNotifier {
  TaskEditViewModel(this._taskRepository);

  TaskRepository _taskRepository;

  Future<void> insertNewTask(Task task) async {
    task = task.copyWith(id: Uuid().v4());
    await _taskRepository.insertTask(task);
  }

  Future<void> updateTask(Task task) async {
    await _taskRepository.updateTask(task);
  }
}
