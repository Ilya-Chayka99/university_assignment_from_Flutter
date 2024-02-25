

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university_assignment/features/repositories/image/image_repositiry.dart';
import 'package:university_assignment/features/task_5/User.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final loginController = TextEditingController();
  final passController = TextEditingController();
  final dateController = TextEditingController();
  bool passwordVisibility = false;
  File? image;

  Future pickImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if(image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
         iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            centerTitle: true,
        title: const Text("Регистрация",style:TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
        ),),
      ),
      body:ListView(
        children: [Form(
          key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 70,
                          child: TextFormField(
                            onChanged: (_) => {
                              setState(() {}),
                            },
                            decoration: InputDecoration(
                               labelText: 'Введите Имя*',
                               labelStyle: const TextStyle(
                                color: Colors.white
                               ),
                               suffixIcon: nameController.text.isNotEmpty?
                                InkWell(
                                  onTap: (){
                                    nameController.clear();
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.clear,size: 30,color: Colors.white,),
                                ):null,
                                enabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                    width: 1, color: Color.fromARGB(255, 219, 201, 10)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            ),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            controller: nameController,
                            validator: (value) {
                              if(value == null || value.isEmpty || value.replaceAll(' ', '') == '') return "Поле имени не может быть пустым!!!";
                              return null;
                            },
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 70,
                          child: TextFormField(
                            onChanged: (_) => {
                              setState(() {}),
                            },
                            decoration: InputDecoration(
                               labelText: 'Введите Фамилию*',
                               labelStyle: const TextStyle(
                                color: Colors.white
                               ),
                               suffixIcon: surnameController.text.isNotEmpty?
                                InkWell(
                                  onTap: (){
                                    surnameController.clear();
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.clear,size: 30,color: Colors.white,),
                                ):null,
                                enabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                    width: 1, color: Color.fromARGB(255, 219, 201, 10)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            ),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            controller: surnameController,
                            validator: (value) {
                              if(value == null || value.isEmpty || value.replaceAll(' ', '') == '') return "Поле фамилии не может быть пустым!!!";
                              return null;
                            },
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 70,
                          child: TextFormField(
                            onChanged: (_) => {
                              setState(() {}),
                            },
                            decoration: InputDecoration(
                               labelText: 'Введите логин*',
                               labelStyle: const TextStyle(
                                color: Colors.white
                               ),
                               suffixIcon: loginController.text.isNotEmpty?
                                InkWell(
                                  onTap: (){
                                    loginController.clear();
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.clear,size: 30,color: Colors.white,),
                                ):null,
                                enabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                    width: 1, color: Color.fromARGB(255, 219, 201, 10)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            ),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            controller: loginController,
                            validator: (value) {
                              if(value == null || value.isEmpty || value.replaceAll(' ', '') == '') return "Поле логина не может быть пустым!!!";
                              return null;
                            },
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 70,
                          child: TextFormField(
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Введите пароль*',
                               labelStyle: const TextStyle(
                                color: Colors.white
                               ),
                               suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility = !passwordVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 30,
                                  ),
                                ),
                                enabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                    width: 1, color: Color.fromARGB(255, 219, 201, 10)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            ),
                             style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            controller: passController,
                            validator: (value) {
                              if(value == null || value.isEmpty) return "Укажите пароль!";
                              return null;
                            },
                          )
                        )
                      ],
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 70,
                          child: TextFormField(
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Повтор пароля*',
                               labelStyle: const TextStyle(
                                color: Colors.white
                               ),
                               suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility = !passwordVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 30,
                                  ),
                                ),
                                enabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                    width: 1, color: Color.fromARGB(255, 219, 201, 10)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            ),
                             style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) return "Укажите пароль!";
                              if(value != passController.text) return "Пароли не совпадают!";
                              return null;
                            },
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 70,
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: 'Дата рождения*',
                               labelStyle: const TextStyle(
                                color: Colors.white
                               ),
                                enabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                    width: 1, color: Color.fromARGB(255, 219, 201, 10)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1, color: Color.fromARGB(255, 219, 201, 10)
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            ),
                             style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            controller: dateController,
                            validator: (value) {
                              if(value == null || value.isEmpty) return "Укажите дату рождения!";
                              return null;
                            },
                          )
                        )
                      ],
                    ),
                  ),
                  image != null?
                    ClipOval(
                      child: Image.file(
                        image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ):Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 175,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                            onPressed: () {
                              pickImage(ImageSource.gallery);
                            },
                            child: const Text('Загрузить аватар',style: TextStyle(
                          color: Color.fromARGB(255, 54, 49, 0)
                                              ),),
                          ),
                        ),
                        SizedBox(
                          width: 175,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                            onPressed: () {
                              pickImage(ImageSource.camera);
                            },
                            child: const Text('Сделать фото',style: TextStyle(
                          color: Color.fromARGB(255, 54, 49, 0)
                                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 375,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                            onPressed: () async{
                              _formKey.currentState!.validate();
                              if (_formKey.currentState!.validate() && image != null) {
                                if(image == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите аватар!'), backgroundColor: Colors.yellow,));
                                  return;
                                }
                                String article = await Repository.seveImage(image!);
                                User user = User(nameController.text, 
                                  surnameController.text, loginController.text, 
                                  passController.text,DateTime.parse(dateController.text) , article);
                                  String a = await Repository.seveUser(user);
                                  if(a == "yes") {
                                    Navigator.of(context).pushNamed('/task-5');
                                  } else{
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пользователь с таким логином уже зарегистрирован!'), backgroundColor: Colors.red,));
                                    return;
                                  }
                              }
                            },
                            child: const Text('Регистрация',style: TextStyle(
                          color: Color.fromARGB(255, 54, 49, 0)
                                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ),
            )
        ),]
      ),
    );
  }
}