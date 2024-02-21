

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passController = TextEditingController();
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
         iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            centerTitle: true,
        title: const Text("Авторизация",style:TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
        ),),
      ),
      body:Form(
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
                             labelText: 'Введите логин',
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
                            labelText: 'Введите пароль',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 175,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                          onPressed: () {
                            _formKey.currentState!.validate();
                            if (_formKey.currentState!.validate()) {
                              // Map<String,String> map = {
                              //   'name':nameController.text,
                              //   'ege':egeController.text,
                              //   'gender':_gender.toString()
                              // };
                              // Navigator.of(context).pushNamed('/task-1-details',arguments:map);
                            }
                          },
                          child: const Text('Войти',style: TextStyle(
                          color: Color.fromARGB(255, 54, 49, 0)
                        ),),
                        ),
                      ),
                      SizedBox(
                        width: 175,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                          onPressed: () {
                            setState(() {
                              
                            });
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
      ),
    );
  }
}