// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$_$_TaskFromJson(Map<String, dynamic> json) {
  return _$_Task(
    id: json['id'] as String?,
    title: json['title'] as String? ?? '',
    task: json['task'] as String? ?? '',
    completed: json['completed'] as int? ?? 0,
  );
}

Map<String, dynamic> _$_$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'task': instance.task,
      'completed': instance.completed,
    };
