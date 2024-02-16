import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university_assignment/university_assignment_app.dart';

import '../repositories/money/money_repository.dart';

Map<String, dynamic>? language;

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String getText(String key) => language![key];

  String get(String key) => getText(key);
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final string = await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    language = json.decode(string);
    return SynchronousFuture<AppLocalizations>(AppLocalizations());
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}



class TaskApi extends StatefulWidget {
  const TaskApi({super.key});

  @override
  State<TaskApi> createState() => _TaskApiState();
}

class _TaskApiState extends State<TaskApi> {

  String? _selectedLocation = 'RU';
  String? _selectedMoney = 'Рубли';
  final List<String> _locations = ['RU','ENG'];  //UAH KRW THB USD RUB NOK TRY
  final List<String> _money = ['Вона','Бат','Гривна','Доллар-США','Рубли','Крона-Норвегия','Лира'];
  late List<dynamic>? result = null;
  

  final numberConvert = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.getText("title"),style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 28, 22),
        ),
      body:Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(AppLocalizations.of(context)!.getText("vibL"), style: const TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w500),),
                DropdownButton(
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                    if(newValue == 'RU'){
                      Locale newLocale = const Locale('ru');
                      UniversityAssignment.setLocale(context, newLocale);
                    }else{
                      Locale newLocale = const Locale('eu');
                      UniversityAssignment.setLocale(context, newLocale);
                    }
                  });
                },
                items:_locations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location,style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),),
                  );
                }).toList(),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            Text(AppLocalizations.of(context)!.getText("title2"),style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),),
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500
                ),
                keyboardType: TextInputType.number,
                controller: numberConvert,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(AppLocalizations.of(context)!.getText("vibL2"), style: const TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w500),),
                DropdownButton(
                value: _selectedMoney,
                onChanged: (newValue) {
                  setState(() {
                    _selectedMoney = newValue;
                  });
                },
                items:_money.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location,style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),),
                  );
                }).toList(),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 219, 201, 10),
                fixedSize: const Size(300, 50)
              ),
              onPressed: () async {
                if(double.parse(numberConvert.text.replaceAll(',', '.')) < 0) return;
                  switch (_selectedMoney){//UAH KRW THB USD RUB NOK TRY
                    case 'Рубли':
                      result = await MoneyRepository().getMoneyList('RUB'); 
                      break;
                    case 'Вона':
                      result = await MoneyRepository().getMoneyList('KRW'); 
                      break;
                    case 'Бат':
                      result = await MoneyRepository().getMoneyList('THB'); 
                      break;
                    case 'Гривна':
                      result = await MoneyRepository().getMoneyList('UAH'); 
                      break;
                    case 'Доллар-США':
                      result = await MoneyRepository().getMoneyList('USD'); 
                      break;
                    case 'Крона-Норвегия':
                      result = await MoneyRepository().getMoneyList('NOK'); 
                      break;
                    case 'Лира':
                      result = await MoneyRepository().getMoneyList('TRY'); 
                      break;
                  }
                debugPrint(result.toString());
                setState(() {});
              },
              child: Text(AppLocalizations.of(context)!.getText("bu"),style: const TextStyle(
                color: Color.fromARGB(255, 54, 49, 0)
              ),),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            (result != null)?(
            SizedBox(
              height: 430,
              child: ListView.separated(
                itemCount: _money.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context,i)=> ListTile(
                  title: Text('$_selectedMoney -> ${result![i]['code']}',style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text('${double.parse(numberConvert.text.replaceAll(',', '.'))}   ->   ${double.parse(numberConvert.text.replaceAll(',', '.')) * result![i]['value']}',style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(Icons.check,color: Color.fromARGB(255, 255, 255, 255),),
                  leading: const Icon(Icons.attach_money,color: Color.fromARGB(255, 255, 255, 255),),
                )
              ),
            )):Container(),
          ],
        ),
      ),
    );
  }
}



