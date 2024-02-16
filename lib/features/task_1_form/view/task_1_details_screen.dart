import 'dart:math';

import 'package:flutter/material.dart';
import 'package:university_assignment/features/task_1_form/widgets/wifgets.dart';

class TaskFormDetails extends StatefulWidget {
  const TaskFormDetails({super.key});

  @override
  State<TaskFormDetails> createState() => _TaskFormDetailsState();
}

class _TaskFormDetailsState extends State<TaskFormDetails> {
  Map<String,String>? info;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if(args == null || args is! Map<String,String>) return;
    info = args; 
    super.didChangeDependencies();
  }
  int color = 29;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, color, 41, 33),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        centerTitle: true,
        title: const Text("Задание 1 - Информация\n                с формы",style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
          
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        ),
      body:  Center(
        child: Column(
          children: [
            Text("Ваше имя: ${info?['name']}",style: const TextStyle(fontSize: 24, color: Color.fromARGB(255, 255, 255, 255),)),
            Text("Ваш возраст: ${info?['ege']}",style: const TextStyle(fontSize: 24,color: Color.fromARGB(255, 255, 255, 255),),),
            Text("Ваш пол: ${info?['gender'] == GenderList.male.toString() ?"Мужской":"Женский"}",style: const TextStyle(fontSize: 24,color: Color.fromARGB(255, 255, 255, 255),),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                   style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                    onPressed: () {
                      setState(() {
                        color = Random().nextInt(255);
                      });
                    },
                    child: const Text('Сменить фон',style: TextStyle(
                      color: Color.fromARGB(255, 54, 49, 0)
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/task-1-list');
                    },
                    child: const Text('Перейти',style: TextStyle(
                      color: Color.fromARGB(255, 54, 49, 0)
                    ),),
                  ),
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}