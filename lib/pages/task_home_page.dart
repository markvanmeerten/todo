import 'package:flutter/material.dart';
import 'package:todo/models/task.dart' as model;
import 'package:todo/widgets/task.dart' as task_widget;
import 'package:todo/services/task_service.dart';
import 'package:todo/widgets/add_task_dialog.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final taskService = TaskService();

  Future<void> openAddTaskDialog() async {
    final newTaskTitle = await showDialog<String>(
      context: context,
      builder: (context) {
        return const AddTaskDialog();
      },
    );

    if (newTaskTitle == null || newTaskTitle.isEmpty) return;

    setState(() {
      taskService.addTask(newTaskTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<model.Task> tasks = taskService.getTasks();

    return Scaffold(
      appBar: AppBar(title: const Text('Todo-app')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: task_widget.Task(
              task: task,
              onChanged: () {
                setState(() {
                  taskService.toggleTask(task);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
