import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

enum GenderList {male, female}
class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final egeController = TextEditingController();
  GenderList? _gender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
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
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Ваш пол: ",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 50,
                        child:  RadioListTile(
                          title: const Text('Мужской',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
                          value: GenderList.male,
                          groupValue: _gender, 
                          onChanged:(value) {setState(() { _gender = value as GenderList;});}, 
                        )
                      ),
                       SizedBox(
                        width: 200,
                        height: 50,
                        child:  RadioListTile(
                          title: const Text('Женский',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
                          value: GenderList.female,
                          groupValue: _gender, 
                          onChanged:(value) {setState(() { _gender = value as GenderList;});}, 
                        )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                        onPressed: () {
                          String text = '';
                          _formKey.currentState!.validate();
                          if(_gender == null) {
                            text = "Выберите свой пол!";
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text), backgroundColor: Colors.red,));
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            Map<String,String> map = {
                              'name':nameController.text,
                              'ege':egeController.text,
                              'gender':_gender.toString()
                            };
                            Navigator.of(context).pushNamed('/task-1-details',arguments:map);
                          }
                        },
                        child: const Text('Отпарвить',style: TextStyle(
                      color: Color.fromARGB(255, 54, 49, 0)
                    ),),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                        onPressed: () {
                          setState(() {
                            nameController.text = '';
                            egeController.text = '';
                            _gender = null;
                          });
                        },
                        child: const Text('Сбросить',style: TextStyle(
                      color: Color.fromARGB(255, 54, 49, 0)
                    ),),
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