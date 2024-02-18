
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:university_assignment/features/task_4/note.dart';
import 'package:university_assignment/features/task_4/tag.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Box<Note> noteBox;
  late Box<Tag> tagBox;
  List<Tag> tags = [];
  Set<Tag> filters ={};
  List<Tag> mass = [];

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box<Note>("note1");
    tagBox = Hive.box<Tag>("tag1");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Builder(builder: (context) {
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
            bottom: const TabBar(
              indicatorColor: Color.fromARGB(255, 219, 201, 10),
              dividerColor: Color.fromARGB(0, 0, 0, 0),
              unselectedLabelColor: Colors.white,
              labelColor: Color.fromARGB(255, 219, 201, 10),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.assignment),
                ),
                Tab(
                  icon: Icon(Icons.loyalty),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: noteBox.listenable(),
                builder: (context, Box<Note> box,_) {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context,index){
                    Note note = box.getAt(index)!;
                    return Container(
                      clipBehavior: Clip.hardEdge,
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
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(note.description),
                              Wrap(
                                spacing: 5.0,
                                children:  note.tags.cast<Tag>().map((e) {
                                    return ActionChip(
                                      backgroundColor: Colors.white,
                                      disabledColor: Colors.white,
                                      label: Text(e.title), 
                                    );
                                  }).toList(),
                              )
                            ],
                          ),
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
              ValueListenableBuilder(
                valueListenable: tagBox.listenable(),
                builder: (context, Box<Tag> box,_) {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context,index){
                    Tag _tag = tagBox.getAt(index)!;
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Dismissible(
                        key: Key(_tag.title),
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
                            _tag.delete();
                          });
                        },
                        child: ListTile(
                          title: Text(_tag.title),
                          trailing: IconButton(
                            icon: const Icon(Icons.mode_edit),
                            onPressed: () {
                              _editTagDialog(context,_tag);
                            },
                          ),
                        ),
                      ),
                    );
                    },
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(DefaultTabController.of(context).index == 0){
                _addNoteDialog(context);
              }else{
                _addTagDialog(context);
              }
            },
            backgroundColor: const Color.fromARGB(255, 219, 201, 10),
            child: const Icon(Icons.add),
          ),
        );
      },)
    );
  }

  void _addNoteDialog(BuildContext context){
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descController = TextEditingController();
    filters.clear();
    mass.clear();
    for(int i = 0; i < tagBox.length; i++){
      mass.add(tagBox.getAt(i)!);
    }
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        scrollable: true,
        title: const Text("Добавить заметку"),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
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
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      const Text('Выберите тэги'),
                      const SizedBox(height: 5.0),
                      Wrap(
                        spacing: 5.0,
                        children:  mass.map((e) {
                            return FilterChip(
                              backgroundColor: Colors.white,
                              key: Key(e.title),
                              label: Text(e.title), 
                              selected: filters.contains(e),
                              onSelected: (bool selected) {
                                setState(() {
                                  if(selected){
                                    filters.add(e);
                                  }else {
                                    filters.remove(e);
                                  }
                                });
                              }
                            );
                          }).toList(),
                      )
                    ],
                  ),
                )
              ],
            );
          },
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
      Note tmp = Note(title: title, description: description, dateTime: DateTime.now(),tags: HiveList(tagBox) );
      for (var element in filters) {tmp.tags.add(element);}
      noteBox.add(tmp);
    }
  }

  void _editNoteDialog(BuildContext context,Note note){
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descController = TextEditingController();
    _titleController.text = note.title;
    _descController.text = note.description;
    filters.clear();
    filters.addAll(note.tags.cast<Tag>());
    mass.clear();
    for(int i = 0; i < tagBox.length; i++){
      mass.add(tagBox.getAt(i)!);
    }

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        scrollable: true,
        title: const Text("Редактирование заметки"),
        content: StatefulBuilder(
          builder:(context, setState) {
            return Column(
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
                Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          const Text('Выберите тэги'),
                          const SizedBox(height: 5.0),
                          Wrap(
                            spacing: 5.0,
                            children:  mass.map((e) {
                                return FilterChip(
                                  backgroundColor: Colors.white,
                                  key: Key(e.title),
                                  label: Text(e.title), 
                                  selected: filters.contains(e),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if(selected){
                                        filters.add(e);
                                      }else {
                                        filters.remove(e);
                                      }
                                    });
                                  }
                                );
                              }).toList(),
                          )
                        ],
                      ),
                    )
              ],
            );
          }, 
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
              note.tags.clear();
              for (var element in filters) {note.tags.add(element);}
              note.save();
            }),
            Navigator.pop(context)
          }, 
          child: const Text("Сохранить"))
        ],
      )
    );
  }

  void _editTagDialog(BuildContext context,Tag tag){
    TextEditingController _titleController = TextEditingController();
    _titleController.text = tag.title;

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        scrollable: true,
        title: const Text("Редактирование Тэг"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Заголовок"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: ()=>{
            Navigator.pop(context)
          }, 
          child: const Text("Закрыть")),
          TextButton(onPressed: ()=>{
            tag.title = _titleController.text,
            setState(() {
               tag.save();
            //  noteBox.add(note);
            }),
            Navigator.pop(context)
          }, 
          child: const Text("Сохранить"))
        ],
      )
    );
  }

  void _addTagDialog(BuildContext context){
    TextEditingController _titleController = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        scrollable: true,
        title: const Text("Добавить Тэг"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Заголовок"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: ()=>{
            Navigator.pop(context)
          }, 
          child: const Text("Закрыть")),
          TextButton(onPressed: ()=>{
            _addTag(_titleController.text),
            Navigator.pop(context)
          }, 
          child: const Text("Добавить"))
        ],
      )
    );
  }
  
  void _addTag(String title){
    late List<String> tpm = [];
    for(int i = 0; i < tagBox.length; i++){
      tpm.add(tagBox.getAt(i)!.title);
    }
    if(title.isNotEmpty && !tpm.contains(title)){
      tagBox.add(
        Tag(title: title)
      );
    }
  }

}