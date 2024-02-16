
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:university_assignment/features/task_4/note.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Box<Note> noteBox;

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box<Note>("note");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        centerTitle: true,
        title: const Text("Заметки",style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        ),
      body:ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, Box<Note> box,_) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context,index){
            Note note = box.getAt(index)!;
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Dismissible(
                key: Key(note.dateTime.toString()),
                direction:DismissDirection.endToStart ,
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent,
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal:20 ),
                  child: const Icon(Icons.delete, color: Colors.white,),
                ),
                onDismissed:(direction) {
                  setState(() {
                    note.delete();
                  });
                },
                child: ListTile(
                  title: Text("${note.title} - ${DateFormat.yMMMd().add_Hm().format(note.dateTime)}"),
                  subtitle: Text(note.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.mode_edit),
                    onPressed: () {
                      _editNoteDialog(context,note);
                    },
                  ),
                ),
              ),
            );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNoteDialog(context);
        },
        backgroundColor: const Color.fromARGB(255, 219, 201, 10),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNoteDialog(BuildContext context){
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descController = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Добавить заметку"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Заголовок"),
            ),
            TextField(
              maxLines: 3,
              minLines: 1,
              controller: _descController,
              decoration: const InputDecoration(labelText: "Описание"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: ()=>{
            Navigator.pop(context)
          }, 
          child: const Text("Закрыть")),
          TextButton(onPressed: ()=>{
            _addNode(_titleController.text,_descController.text),
            Navigator.pop(context)
          }, 
          child: const Text("Добавить"))
        ],
      )
    );
  }

  void _addNode(String title, String description){
    if(title.isNotEmpty){
      noteBox.add(
        Note(title: title, description: description, dateTime: DateTime.now())
      );
    }
  }

  void _editNoteDialog(BuildContext context,Note note){
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descController = TextEditingController();
    _titleController.text = note.title;
    _descController.text = note.description;

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Редактирование заметки"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Заголовок"),
            ),
            TextField(
              maxLines: 3,
              minLines: 1,
              controller: _descController,
              decoration: const InputDecoration(labelText: "Описание"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: ()=>{
            Navigator.pop(context)
          }, 
          child: const Text("Закрыть")),
          TextButton(onPressed: ()=>{
            note.title = _titleController.text,
            note.description = _descController.text,
            setState(() {
             noteBox.add(note);
            }),
            Navigator.pop(context)
          }, 
          child: const Text("Сохранить"))
        ],
      )
    );
  }


}


