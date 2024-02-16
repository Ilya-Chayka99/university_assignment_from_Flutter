


import 'package:hive_flutter/hive_flutter.dart';
import 'package:university_assignment/features/task_4/note.dart';

class NoteAdapter extends TypeAdapter<Note>{
  @override
  final int typeId = 0;
  
  @override
  Note read(BinaryReader reader) {
    return Note(title: reader.readString(),
    description: reader.readString(),
    dateTime: DateTime.parse(reader.readString()));
  }
  
  @override
  void write(BinaryWriter writer, Note obj) {
     writer.writeString(obj.title);
     writer.writeString(obj.description);
     writer.writeString(obj.dateTime.toIso8601String());
  }

  
}