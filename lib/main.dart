import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:university_assignment/features/task_4/note.dart';
import 'package:university_assignment/features/task_4/noteAdapter.dart';
import 'package:university_assignment/university_assignment_app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>("note");
    
  runApp(const UniversityAssignment());
}




