import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Tag extends HiveObject{
  @HiveField(0)
  late String title;
  Tag({
    required this.title,
  });
}