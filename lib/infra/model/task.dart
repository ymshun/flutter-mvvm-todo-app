import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task implements _$Task {
  const Task._();

  factory Task({
    @Default(null) String? id,
    @Default('') String title,
    @Default('') String task,
    @Default(0) int completed,  // SQLiteにはbool値ないのでintで管理 0 -> false; 1 -> true;
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  bool isCompleted() => this.completed == 1;
}
