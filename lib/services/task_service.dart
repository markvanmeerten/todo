import 'package:todo/models/task.dart';

class TaskService {
  final List<Task> _tasks = [
    Task(id: "1", title: "Boodschappen doen", done: false),
    Task(id: "2", title: "Huiswerk maken", done: true),
    Task(id: "3", title: "Flutter oefenen", done: false),
  ];

  List<Task> getTasks() {
    return _tasks;
  }
}