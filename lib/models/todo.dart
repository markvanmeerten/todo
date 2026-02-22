import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String title;
  final bool done;

  Todo({required this.id, required this.title, required this.done});

  factory Todo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Todo(
      id: doc.id,
      title: data['title'] ?? '',
      done: data['done'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'done': done,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
