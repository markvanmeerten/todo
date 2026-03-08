import 'package:flutter/material.dart';
import 'package:todo/models/task.dart' as model;

class Task extends StatelessWidget {
  const Task({
    super.key,
    required this.task,
    required this.onChanged,
  });

  final model.Task task;
  final VoidCallback onChanged;

   @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: task.done,
          onChanged: (newValue) {
            onChanged();
          },
        ),
        Text(task.title),
      ],
    );
  }
}
