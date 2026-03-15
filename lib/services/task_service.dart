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

  void toggleTask(Task task) {
    final index = _tasks.indexOf(task);

    _tasks[index] = Task(
      id: task.id,
      title: task.title,
      done: !task.done,
    );
  }

  void addTask(String title) {
    _tasks.add(
      Task(
        id: DateTime.now().toString(), 
        title: title, 
        done: false
      )
    );
  }
}
