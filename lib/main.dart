import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
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