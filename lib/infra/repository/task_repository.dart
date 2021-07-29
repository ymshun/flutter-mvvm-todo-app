import 'package:todo_app/infra/model/task.dart';

abstract class TaskRepository {
  /// すべてのタスクを取得
  Future<List<Task>> getAllTasks();

  /// 新規タスクを挿入
  Future<void> insertTask(Task task);

  /// タスクを更新
  Future<void> updateTask(Task task);

  /// タスクの削除
  Future<void> deleteTask(String id);
}
