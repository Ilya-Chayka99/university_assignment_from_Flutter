

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:university_assignment/features/repositories/image/image_repositiry.dart';
import 'package:university_assignment/features/task_5/User.dart';
import 'package:university_assignment/features/task_5/playlist_provider.dart';
import 'package:university_assignment/features/task_5/song.dart';
import 'package:university_assignment/features/task_5/songPage.dart';
import 'package:http/http.dart' as http;

class MainAppTask5 extends StatefulWidget {
  const MainAppTask5({super.key});

  @override
  State<MainAppTask5> createState() => _MainAppTask5State();
}

class _MainAppTask5State extends State<MainAppTask5> {
  Map<String,dynamic>? info;
  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final loginController = TextEditingController();
  final dateController = TextEditingController();
  final passController = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  File? images;
  bool passwordVisibility = false;
  DateTime? selectedDate;
  String _location = '';
  late Map<String,dynamic>? map = null;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if(args == null || args is! Map<String,dynamic>) return;
    info = args;
    nameController.text = info?['name'];
    surnameController.text = info?['lastName'];
    loginController.text = info?['login'];
    dateController.text = formatter.format(DateTime.parse(info!['birghtDay']));
   
    super.didChangeDependencies();
  }
  


  Future pickImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if(image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      images = imageTemporary;
      Navigator.pop(context);
      _editProfileDialog(context);
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Future _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        dateController.text = formatter.format(selected);
      });
    }
  }

    Future<void> _getLocation() async {
      final response = await Dio()
      .get('https://ipapi.co/json');
      // final response = await http.get(Uri.parse('https://ipapi.co/json'));
      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _location = '${data['latitude']},${data['longitude']}';
        });
      } else {
        setState(() {
          _location = 'Failed to get location';
        });
      }
      _getP();
    }
    Future<void> _getP() async {
      final response = await Dio()
      .get('http://api.weatherapi.com/v1/current.json?key=b74d4f613b9b4a679a9193623242602 &q=$_location');
      // final response = await http.get(Uri.parse('http://api.weatherapi.com/v1/current.json?key=b74d4f613b9b4a679a9193623242602 &q=$_location'));
      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
         map = data;
        });
      }
    }

  late final dynamic playListProvider;
  @override
  void initState() {
    super.initState();
    _getLocation();
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }
  void goToSong(int index){
    playListProvider.currSongIndex = index;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SongPage()));
  }


  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child:Image.network(
                  'http://192.168.1.3:8080/image/${info?['avatarHash']}',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Имя Фамилия: ${info!['name']} ${info!['lastName']}',
                  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                  Text('Логин: ${info!['login']}',
                  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                  Text('Дата рождения: ${formatter.format(DateTime.parse(info!['birghtDay']))}',
                  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                ],
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 175,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                  onPressed: () {
                    _editProfileDialog(context);
                  },
                  child: const Text('Редактировать',style: TextStyle(
                color: Color.fromARGB(255, 54, 49, 0)),),
                ),
              ),
              SizedBox(
                width: 175,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                  onPressed: () {
                    _editPasswordDialog(context);
                  },
                  child: const Text('Сменить пароль',style: TextStyle(
                color: Color.fromARGB(255, 54, 49, 0)),),
                ),
              ),
            ],
          )
        ],
      ),
      map !={} && map != null?
      Center(
        child: Column(
          children: [
            Text('${map!['location']?['name']} / ${map?['location']?['country']}',style: const TextStyle(color: Colors.white,fontSize: 30),),
            
            Image.network('https:${map!['current']?['condition']?['icon']}'),
            Text(map?['current']?['condition']?['text'],style: const TextStyle(color: Colors.white,fontSize: 30),),
            Text('Температура: ${map!['current']['temp_c'].toString()}',style: const TextStyle(color: Colors.white,fontSize: 30),),
            
            Text('Давление: ${map?['current']?['pressure_mb']}',style: const TextStyle(color: Colors.white,fontSize: 30),),
            Text('Скорость ветра: ${map?['current']?['wind_kph']} км/ч',style: const TextStyle(color: Colors.white,fontSize: 30),),
            Text('Пследнее обновление: ${map?['current']?['last_updated']}',style: const TextStyle(color: Colors.white,fontSize: 20),),
            
            ElevatedButton(onPressed: (){_getLocation();}, child: const Text('Обновить'))
            // Text(_location,style: TextStyle(color: Colors.white,fontSize: 30),)
          ],
        ),
      ):Container(),
      Consumer<PlayListProvider>(
        builder: (context,value,child) {
          final List<Song> playlist = value.playlist;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context,index){
              final Song song = playlist[index];
              return ListTile(
                title: Text(song.songName,style: const TextStyle(color: Colors.white),),
                subtitle: Text(song.artistName,style: const TextStyle(color: Colors.grey),),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index) ,
              );
            });
        }
      ),
      
    ];

    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        child: ListView(
          children: [
            ListTile(
              title: TextButton(
                onPressed: (){
                _onItemTapped(0);
                Navigator.pop(context);
              }, 
              child: const Text("Личный кабинет",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),)),
            ),
            ListTile(
              title: TextButton(
                onPressed: (){
                _onItemTapped(1);
                Navigator.pop(context);
              }, 
              child: const Text("Погода",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),)),
            ),
            ListTile(
              title: TextButton(
                onPressed: (){
                _onItemTapped(2);
                Navigator.pop(context);
              }, 
              child: const Text("Музыка",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
         iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            centerTitle: true,
        title: const Text("5 laba",style:TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
        ),),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
    );
  }

 void _editPasswordDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        scrollable: true,
        title: const Text("Редактирование пароля",style: TextStyle(color: Colors.white),),
        content: Form(
          key: _formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                   
                  ]
          ),
        ),
        actions: [
          TextButton(onPressed: ()=>{
            setState(() {
              passController.text = '';
            }),
            Navigator.pop(context)
          }, 
          child: const Text("Закрыть")),
          TextButton(onPressed: ()async{
            _formKey2.currentState!.validate();
            if (_formKey2.currentState!.validate()) {
              User user = User(nameController.text, 
                surnameController.text, loginController.text, 
                passController.text,DateTime.parse(dateController.text), info?['avatarHash']);
              String a = await Repository.updateUser(user,info?['id']);
                 setState(() {
                  info?['password'] = passController.text;
                  passController.text='';
                });
              Navigator.pop(context);
            }

            
          }, 
          child: const Text("Обновить"))
        ],
      )
    );
  }

  void _editProfileDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        scrollable: true,
        title: const Text("Редактирование профиля",style: TextStyle(color: Colors.white),),
        content: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                              readOnly: true,
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
                          ),
                          SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                            onPressed: () {
                               _selectDate(context);
                            },
                            child: const Text('Указать дату рождения',style: TextStyle(
                          color: Color.fromARGB(255, 54, 49, 0)
                                              ),),
                          ),
                        ),
                        ],
                      ),
                    ),
                    images != null?
                      ClipOval(
                        child: Image.file(
                          images!,
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
                            width: 125,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                              onPressed: () {
                                pickImage(ImageSource.gallery);
                              },
                              child: const Text('Загрузить аватар',style: TextStyle(
                            color: Color.fromARGB(255, 54, 49, 0),
                                                ),textAlign: TextAlign.center,),
                            ),
                          ),
                          SizedBox(
                            width: 125,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 201, 10)),
                              onPressed: () {
                                pickImage(ImageSource.camera);
                              },
                              child: const Text('Сделать фото',style: TextStyle(
                            color: Color.fromARGB(255, 54, 49, 0)
                                                ),textAlign: TextAlign.center,),
                            ),
                          ),
                        ],
                      ),
                    ),
                   
                  ]
          ),
        ),
        actions: [
          TextButton(onPressed: ()=>{
            setState(() {
              nameController.text = info?['name'];
              surnameController.text = info?['lastName'];
              loginController.text = info?['login'];
              dateController.text = formatter.format(DateTime.parse(info!['birghtDay']));
              images = null;
            }),
            Navigator.pop(context)
          }, 
          child: const Text("Закрыть")),
          TextButton(onPressed: ()async{
            _formKey.currentState!.validate();
            if (_formKey.currentState!.validate()) {
              String article = info?['avatarHash'];
              if(images != null){
                article = await Repository.seveImage(images!);
              }
              User user = User(nameController.text, 
                surnameController.text, loginController.text, 
                info?['password'],DateTime.parse(dateController.text), article);
              String a = await Repository.updateUser(user,info?['id']);
              if(a == "no") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пользователь с таким логином уже зарегистрирован!'), backgroundColor: Colors.red,));
              }else{
                 setState(() {
                  info?['name'] = nameController.text;
                  info?['lastName'] = surnameController.text;
                  info?['login'] = loginController.text;
                  info?['birghtDay'] = dateController.text;
                  info?['avatarHash'] = article;
                  images = null;
                });
              }
              setState(() {
                nameController.text = info?['name'];
                surnameController.text = info?['lastName'];
                loginController.text = info?['login'];
                dateController.text = formatter.format(DateTime.parse(info!['birghtDay']));
                images = null;
              });
              
              Navigator.pop(context);
            }

            
          }, 
          child: const Text("Обновить"))
        ],
      )
    );
  }
}