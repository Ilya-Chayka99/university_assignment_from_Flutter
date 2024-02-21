

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final egeController = TextEditingController();

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
                      const Text("Введите имя: ",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
                      SizedBox(
                        width: 300,
                        height: 70,
                        child: TextFormField(
                          decoration: const InputDecoration(
                             enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                  width: 3, color: Colors.greenAccent),
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
                      const Text("Введите возраст: ",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
                      SizedBox(
                        width: 300,
                        height: 70,
                        child: TextFormField(
                           style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
                              FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: egeController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Поле возраста не может быть пустым!!!";
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
                            String text = '';
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
                              nameController.text = '';
                              egeController.text = '';
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