import 'package:university_assignment/features/task_1_form/task_1_form.dart';
import 'package:university_assignment/features/task_2_calculate/task_2_calculate.dart';
import 'package:university_assignment/features/task_3_api/task_3_api.dart';
import '../features/task_selection/task_selection.dart';

final routes = {
        '/':(context) => const TaskSelectionPage(),
        '/task-1':(context) => const TaskForm(),
        '/task-1-details':(context) => const TaskFormDetails(),
        '/task-1-list':(context) => const TaskList(),
        '/task-2':(context) => const TaskCalculate(),
        '/task-3':(context) => const TaskApi(),
      };