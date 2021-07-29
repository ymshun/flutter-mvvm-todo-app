import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/infra/model/task.dart';
import 'package:todo_app/presentation/home/home_view_model.dart';

class TaskItem extends HookWidget {
  TaskItem(this.onTap, this._viewModel, this._index);

  final void Function(Task) onTap;
  final HomeViewModel _viewModel;
  final int _index;

  @override
  Widget build(BuildContext context) {
    Task _task = _viewModel.taskList![_index];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 2,
      child: InkWell(
        onTap: () => onTap(_task),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: _task.isCompleted(),
                // value: _isChecked,
                // value: false,
                onChanged: (bool? value) {
                  // print('${task.getTaskCompleted()}');
                  print(value);
                  _viewModel.onCompletedTask(_index, value ?? false);
                },
              ),
              Flexible(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DefaultTextStyle(
                        child: Text(
                          'Task: ${_task.title}',
                          style: TextStyle(decoration: _task.isCompleted() ? TextDecoration.lineThrough : null),
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1!,
                        maxLines: 1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DefaultTextStyle(
                        child: Text('Description: ${_task.task}'),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption!,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
