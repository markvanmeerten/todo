import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Todo>> getTodos() {
    return _firestore
        .collection('todos')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList(),
        );
  }

  Future<void> addTodo(String title) async {
    await _firestore.collection('todos').add({
      'title': title,
      'done': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> toggleTodo(Todo todo) async {
    await _firestore.collection('todos').doc(todo.id).update({
      'done': !todo.done,
    });
  }

  Future<void> deleteTodo(String id) async {
    await _firestore.collection('todos').doc(id).delete();
  }
}
