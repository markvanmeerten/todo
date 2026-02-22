import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../widgets/task.dart';
import '../widgets/add_todo_dialog.dart';
import '../models/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoService _service = TodoService();

  void _openAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AddTodoDialog(onAdd: (title) => _service.addTodo(title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Mijn Todo App",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Todo>>(
                    stream: _service.getTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "Nog geen taken",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final todos = snapshot.data!;

                      return ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];

                          return Task(
                            todo: todo,
                            onToggle: () => _service.toggleTodo(todo),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
