import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        centerTitle: true,
        title: const Text("Задание 1 - Лист",style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        ),
      body: ListView.separated(
        itemCount: 40,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context,i)=>  ListTile(
          title: Text('Lorem ipsum dolor sit amet. - $i',style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
            ),
          ),
          leading: const Icon(Icons.all_inclusive,color: Colors.white,),
        ),
      )
    );
  }
}