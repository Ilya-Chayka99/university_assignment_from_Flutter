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

    static Future<String> updateUser(User user,int id) async {
    var formData = FormData.fromMap({
      'id':id,
      'name': user.name,
      'lastName': user.lastName,
      'login': user.login,
      'password': user.password,
      'birghtDay': user.birghtDay,
      'avatarHash': user.avatarHash,

    });
    try{
      final response = await Dio()
      .post('http://192.168.1.3:8080/update',
        data: formData
      );
    }catch(e){
      return "no";
    }
    return "yes";
  }

  static Future<Map<String,dynamic>?> loginUser(String login,String password) async {
    var formData = FormData.fromMap({
      'login': login,
      'password': password,
    });
    try{
      final response = await Dio()
      .get('http://192.168.1.3:8080/login',
        data: formData
      );
      return response.data as Map<String,dynamic>;
    }catch(e){
      return null;
    }
    
  }

}