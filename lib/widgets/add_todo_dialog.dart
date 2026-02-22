import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  final Future<void> Function(String title) onAdd;

  const AddTodoDialog({super.key, required this.onAdd});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nieuwe taak toevoegen"),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: "Wat moet je doen?"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuleren"),
        ),
        ElevatedButton(
          onPressed: () async {
            final text = _controller.text.trim();

            if (text.isNotEmpty) {
              await widget.onAdd(text);
            }

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Toevoegen"),
        ),
      ],
    );
  }
}
