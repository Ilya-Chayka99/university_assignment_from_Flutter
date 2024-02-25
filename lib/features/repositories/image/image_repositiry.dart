import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:university_assignment/features/task_5/User.dart';


class Repository{
  static Future<String> seveImage(File file) async {
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: File(file.path).uri.pathSegments.last)
    });
    final response = await Dio()
    .post('http://192.168.1.3:8080/upload',
      options: Options(
        contentType: 'multipart/form-data',),
        data: formData
    );
    final data = json.decode(response.data);
 
    return data["article"].toString();
  }
   static Future<String> seveUser(User user) async {
    var formData = FormData.fromMap({
      'name': user.name,
      'lastName': user.lastName,
      'login': user.login,
      'password': user.password,
      'birghtDay': user.birghtDay,
      'avatarHash': user.avatarHash,

    });
    try{
      final response = await Dio()
      .post('http://192.168.1.3:8080/register',
        data: formData
      );
    }catch(e){
      return "no";
    }
    return "yes";
  }
}