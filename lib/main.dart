import 'package:flutter/material.dart';
import 'package:todo/pages/task_home_page.dart';
import 'package:todo/models/task.dart';

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  TaskApp({super.key});

  final List<Map<String, dynamic>> tasksJson = [
    {"title": "Boodschappen doen", "done": false},
    {"title": "Huiswerk maken", "done": true},
    {"title": "Flutter oefenen", "done": false},
  ];

  final task = Task(id: "1", title: "Leren van mijn fouten", done: false);

  @override
  Widget build(BuildContext context) {

    print("Test1: " + tasksJson[0]["titel"]);
    
    print("Test2: " + task.titel);

    return const MaterialApp(
      home: TaskHomePage(),
    );
  }
}