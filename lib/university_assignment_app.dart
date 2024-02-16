import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:university_assignment/features/task_3_api/task_3_api.dart';
import 'package:university_assignment/router/router.dart';
import 'package:university_assignment/theme/theme.dart';

var local = const Locale('ru');
class UniversityAssignment extends StatefulWidget {
  const UniversityAssignment({super.key});

  static void setLocale(BuildContext context, Locale newLocale) async {
      _UniversityAssignmentState? state = context.findAncestorStateOfType<_UniversityAssignmentState>();
        state?.changeLanguage(newLocale);
     }


  @override
  State<UniversityAssignment> createState() => _UniversityAssignmentState();
}

class _UniversityAssignmentState extends State<UniversityAssignment> {

   Locale _locale = const Locale('ru');

   changeLanguage(Locale locale) {
     setState(() {
      _locale = locale;
     });
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter University assignment',
      theme: theme,
      routes: routes,
      locale: _locale, // switch between "en" and "ru" to see effect
      localizationsDelegates: const [AppLocalizationsDelegate(),GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,],
      supportedLocales: const [Locale('en'), Locale('ru')],
      
    );
  }
}
