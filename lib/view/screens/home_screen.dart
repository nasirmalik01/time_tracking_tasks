import 'package:flutter/material.dart';
import 'package:take_home_challenge/config/language_constants.dart';
import 'package:take_home_challenge/main.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/constants/lists.dart';
import 'package:take_home_challenge/view/screens/completed_task_screen.dart';
import 'package:take_home_challenge/view/screens/in_progress_task_screen.dart';
import 'package:take_home_challenge/view/screens/todo_task_screen.dart';
import 'package:take_home_challenge/view/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedLanguage =  Lists.languageCountryList[0];

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(
            context,
            widget: [
              Padding(
                padding:  EdgeInsets.only(
                    right: sizes.width * 0.01
                ),
                child: DropdownButton<String>(
                  icon: const Icon(Icons.arrow_drop_down),
                  value:  _selectedLanguage,
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: sizes.fontSize14,
                      fontFamily: Fonts.poppinsMedium
                  ),
                  onChanged: (newValue) async {
                    setState(() {
                      _selectedLanguage = newValue!;
                      print(_selectedLanguage);
                    });
                    switch(_selectedLanguage){
                      case AppStrings.english:
                        Locale _locale = await setLocale('en');
                        MyApp.setLocale(context, _locale);
                        break;
                      case AppStrings.spanish:
                        Locale _locale = await setLocale('es');
                        MyApp.setLocale(context, _locale);
                        break;
                      default:
                        Locale _locale = await setLocale('de');
                        MyApp.setLocale(context, _locale);
                        break;
                    }
                  },
                  items: Lists.languageCountryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ]
        ),
        body: TabBarView(
          children: [
            ToDoTaskScreen(),
            const InProgressScreen(),
            const CompletedTaskScreen(),
          ],
        ),
      ),
    );
  }
}
