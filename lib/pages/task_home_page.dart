import 'package:flutter/material.dart';
import 'package:todo/models/task.dart' as model;
import 'package:todo/widgets/task.dart' as widget;
import 'package:todo/services/task_service.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final taskService = TaskService();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<model.Task> tasks = taskService.getTasks();

    return Scaffold(
      appBar: AppBar(title: const Text('Todo-app')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.Task(
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Nieuwe taak"),
                content: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: "Typ een nieuwe taak"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      controller.clear();

                      Navigator.pop(context);
                    },
                    child: Text("Annuleren"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        taskService.addTask(controller.text);
                      });

                      controller.clear();
                      
                      Navigator.pop(context);
                    },
                    child: Text("Toevoegen"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
