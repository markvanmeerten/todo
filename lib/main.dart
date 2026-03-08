import 'package:flutter/material.dart';
import 'package:todo/pages/task_home_page.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskHomePage(),
    );
  }
}




