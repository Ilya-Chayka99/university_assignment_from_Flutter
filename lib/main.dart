import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:university_assignment/features/task_4/note.dart';
import 'package:university_assignment/features/task_4/noteAdapter.dart';
import 'package:university_assignment/features/task_4/tag.dart';
import 'package:university_assignment/features/task_4/tagAdapter.dart';
import 'package:university_assignment/university_assignment_app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TagAdapter());
  await Hive.openBox<Note>("note1");
  await Hive.openBox<Tag>("tag1");
    
  runApp(const UniversityAssignment());
}




