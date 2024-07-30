import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/view/screens/completed_task_screen.dart';
import 'package:take_home_challenge/view/screens/in_progress_task_screen.dart';
import 'package:take_home_challenge/view/screens/todo_task_screen.dart';
import 'package:take_home_challenge/view/widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWidget(),
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
