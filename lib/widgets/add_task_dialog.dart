import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final controller = TextEditingController();

  void submit() {
    final text = controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Nieuwe taak"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: "Typ een nieuwe taak"),
        onSubmitted: (_) => submit(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.clear();

            Navigator.pop(context);
          },
          child: Text("Annuleren"),
        ),
        ElevatedButton(onPressed: submit, child: Text("Toevoegen")),
      ],
    );
  }
}
