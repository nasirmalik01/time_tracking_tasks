import 'package:flutter/cupertino.dart';

class UpdateTaskEvents{}

class UpdateTaskLoadingEvent extends UpdateTaskEvents{
  BuildContext context;
  String id;
  String title;
  String desc;
  String selectedDate;
  String taskPriority;

  UpdateTaskLoadingEvent(
        this.context,
      {
        required this.id,
        required this.title,
        required this.desc,
        required this.selectedDate,
        required this.taskPriority
  });
}
class UpdateTaskSuccessEvent extends UpdateTaskEvents{}
class InitialEvent extends UpdateTaskEvents{}
class UpdateTaskErrorEvent extends UpdateTaskEvents{}