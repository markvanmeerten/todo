import 'package:todo/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class TaskService {
  final CollectionReference<Map<String, dynamic>> _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Stream<List<Task>> getTasks() {
    return _tasksCollection.orderBy('createdAt').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return Task(
          id: doc.id,
          title: data['title'] ?? '',
          done: data['done'] ?? false,
        );
      }).toList();
    });
  }

  Future<void> toggleTask(Task task) async {
    await _tasksCollection.doc(task.id).update({'done': !task.done});
  }

  Future<void> addTask(String title) async {
    await _tasksCollection.add({
      'title': title,
      'done': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
