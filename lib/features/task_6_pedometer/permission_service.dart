
import 'package:permission_handler/permission_handler.dart';

Permission_Checker() async{
  await Permission.activityRecognition.request();
}