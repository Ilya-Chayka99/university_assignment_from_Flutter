import 'package:flutter/material.dart';

class TaskSelectionPage extends StatelessWidget {
  const TaskSelectionPage({super.key});

  final String title = "Выбор задания";
  

  @override
  Widget build(BuildContext context) {
    List<String> textButton = ['Задание 1','Задание 2','Задание 3','Задание 4','Задание 5','Задание 6'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        title: Text(title,style:const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255)
        ),),
      ),
      body: ListView.separated(
        
        itemCount: textButton.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context,i)=> ListTile(
          title: Text(textButton[i],style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,color: Color.fromARGB(255, 255, 255, 255),),
          onTap: () {
            Navigator.of(context).pushNamed('/task-${i+1}');
          },
        )
      )
    );
  }
}

