import 'package:flutter/material.dart';
import 'package:todo/pages/task_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);
	
	runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskHomePage(),
    );
  }
}