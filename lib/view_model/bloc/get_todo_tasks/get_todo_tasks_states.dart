import 'package:take_home_challenge/models/todo_task_model.dart';

class GetToDoTasksStates {}

class GetToDoTasksLoadingState extends GetToDoTasksStates {}

class GetToDoTasksLoadedState extends GetToDoTasksStates {
  List<ToDoTaskModel>? toDoTaskList;
  bool? isDialogOpen;

  GetToDoTasksLoadedState(this.toDoTaskList, {this.isDialogOpen = false});
}

class GetToDoTasksErrorState extends GetToDoTasksStates {}

class DeleteTodoTaskState extends GetToDoTasksStates {}

class FinishTodoTaskState extends GetToDoTasksStates {}
