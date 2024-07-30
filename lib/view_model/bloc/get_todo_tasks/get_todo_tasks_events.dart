import 'package:flutter/material.dart';
import 'package:take_home_challenge/models/todo_task_model.dart';

class GetToDoTasksEvents{}

class GetToDoTasksLoadingEvent extends GetToDoTasksEvents{}
class DeleteTodoTaskEvent extends GetToDoTasksEvents{
  String id;
  DeleteTodoTaskEvent(this.id);
}
class FinishTodoTaskEvent extends GetToDoTasksEvents{
  ToDoTaskModel toDoTaskModel;
  FinishTodoTaskEvent(this.toDoTaskModel);
}