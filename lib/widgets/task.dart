import 'package:flutter/material.dart';
import '../models/todo.dart';

class Task extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;

  const Task({super.key, required this.todo, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Checkbox(value: todo.done, onChanged: (_) => onToggle()),
              Expanded(
                child: Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 18,
                    decoration: todo.done ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
