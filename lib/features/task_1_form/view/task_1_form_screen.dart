import 'package:flutter/material.dart';
import 'package:university_assignment/features/task_1_form/widgets/wifgets.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        centerTitle: true,
        title: const Text("Задание 1 - Форма",style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        ),
      body:  const MyCustomForm(),
    );
  }
}