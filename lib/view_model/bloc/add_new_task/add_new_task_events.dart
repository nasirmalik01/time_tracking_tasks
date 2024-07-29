import 'package:flutter/material.dart';

class AddNewToDoTasksEvents{}

class AddNewTodoTaskLoadingEvent extends AddNewToDoTasksEvents{
  BuildContext context;
  String title;
  String desc;
  String selectedDate;
  String taskPriority;

  AddNewTodoTaskLoadingEvent(
        this.context,
      {
        required this.title,
        required this.desc,
        required this.selectedDate,
        required this.taskPriority
  });
}
class AddNewToDoTaskSuccessEvent extends AddNewToDoTasksEvents{}
class InitialEvent extends AddNewToDoTasksEvents{}
class AddNewTodoTaskErrorEvent extends AddNewToDoTasksEvents{}