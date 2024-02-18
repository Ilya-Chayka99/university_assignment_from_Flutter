import 'package:hive_flutter/hive_flutter.dart';
import 'package:university_assignment/features/task_4/tag.dart';

class TagAdapter extends TypeAdapter<Tag>{
  @override
  final int typeId = 1;
  
  @override
  Tag read(BinaryReader reader) {
    return Tag(title: reader.readString());
  }
  
  @override
  void write(BinaryWriter writer, Tag obj) {
     writer.writeString(obj.title);
  }
}