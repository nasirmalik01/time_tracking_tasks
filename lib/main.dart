import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challenge/firebase_options.dart';
import 'package:take_home_challenge/home_screen.dart';
import 'package:take_home_challenge/utils/methods/methods.dart';
import 'package:take_home_challenge/view/screens/add_new_task_screen.dart';
import 'package:take_home_challenge/view/screens/completed_task_screen.dart';
import 'package:take_home_challenge/view/screens/detail_task_screen.dart';
import 'package:take_home_challenge/view/screens/in_progress_task_screen.dart';
import 'package:take_home_challenge/view/screens/todo_task_screen.dart';
import 'package:take_home_challenge/view/screens/update_task_screen.dart';
import 'package:take_home_challenge/view_model/bloc/add_new_task/add_new_task_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/completed_todo_tasks/completed_tasks_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/detail_timer_task/detail_task_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/get_todo_tasks/get_todo_tasks_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_task/in_progress_task_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/update_task/update_task_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dependencyInjectionSetUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetToDoTasksBloc(),
          child: ToDoTaskScreen(),
        ),
        BlocProvider(
          create: (_) => AddNewTodoTaskBloc(),
          child: const AddNewTaskScreen(),
        ),
        BlocProvider(
          create: (_) => UpdateTaskBloc(),
          child: const UpdateTaskScreen(),
        ),
        BlocProvider(
          create: (_) => CompletedTasksBloc(),
          child: const CompletedTaskScreen(),
        ),
        BlocProvider(
          create: (_) => DetailTaskBloc(),
          child: const DetailTaskScreen(),
        ),
        BlocProvider(
          create: (_) => InProgressTasksBloc(),
          child: const InProgressScreen(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  const HomeScreen()
      ),
    );
  }
}


