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
    return Scaffold(
      appBar: AppBar(title: const Text('Todo-app')),
      body: StreamBuilder<List<model.Task>>(
        stream: taskService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Er ging iets mis: ${snapshot.error}'));
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return const Center(child: Text('Nog geen taken'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.Task(
                  task: task,
                  onChanged: () async {
                    await taskService.toggleTask(task);
                  },
                ),
              );
            },
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
                  autofocus: true,
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
                    onPressed: () async {
                      final text = controller.text.trim();

                      if (text.isEmpty) {
                        return;
                      }

                      await taskService.addTask(controller.text);
                      
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
