import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/infra/database_provider.dart';
import 'package:todo_app/infra/model/task.dart';
import 'package:todo_app/infra/repository/task_repository.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) => TaskRepositoryImpl());

class TaskRepositoryImpl implements TaskRepository {
  final databaseProvider = DatabaseProvider();
  static const taskTable = 'Task';

  @override
  Future<List<Task>> getAllTasks() async {
    final db = await databaseProvider.database;
    final result = await db.rawQuery('SELECT * FROM $taskTable');
    debugPrint('get: $result');
    return result.map((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<void> insertTask(Task task) async {
    debugPrint('insert: $task');
    final db = await databaseProvider.database;
    await db.insert(taskTable, task.toJson());
  }

  @override
  Future<void> updateTask(Task task) async {
    debugPrint('update: $task');
    final db = await databaseProvider.database;
    await db.update(taskTable, task.toJson(), where: 'id =?', whereArgs: [task.id]);
  }

  @override
  Future<void> deleteTask(String id) async {
    debugPrint('delete: $id');
    final db = await databaseProvider.database;
    await db.rawDelete('DELETE FROM $taskTable WHERE id =?', [id]);
  }
}
