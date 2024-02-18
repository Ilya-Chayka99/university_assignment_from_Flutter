import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Note extends HiveObject{
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late DateTime dateTime;
  @HiveField(3)
  late HiveList tags;

  Note( {
    required this.title,
    required this.description,
    required this.dateTime,
    required this.tags,
  });
}