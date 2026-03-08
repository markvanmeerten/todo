import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({
    super.key,
    required this.title,
    required this.initialDone,
  });

  final String title;
  final bool initialDone;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late bool isDone;

  @override
  void initState() {
    super.initState();
    isDone = widget.initialDone;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isDone,
          onChanged: (newValue) {
            setState(() {
              isDone = newValue ?? false;
            });
          },
        ),
        Text(widget.title),
      ],
    );
  }
}