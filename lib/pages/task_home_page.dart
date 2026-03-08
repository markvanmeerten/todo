import 'package:flutter/material.dart';
import 'package:todo/widgets/task.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final List<Map<String, dynamic>> tasksJson = [
    {'title': 'Boodschappen doen', 'done': false},
    {'title': 'Huiswerk maken', 'done': true},
    {'title': 'Flutter oefenen', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo-app'),
      ),
      body: ListView.builder(
        itemCount: tasksJson.length,
        itemBuilder: (context, index) {
          final taskMap = tasksJson[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Task(
              title: taskMap['title'] as String,
              initialDone: taskMap['done'] as bool,
            ),
          );
        },
      ),
    );
  }
}