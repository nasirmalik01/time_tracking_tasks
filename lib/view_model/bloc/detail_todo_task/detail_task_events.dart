import 'package:take_home_challenge/models/todo_task_model.dart';

class  DetailTaskEvents{}

class InProgressTaskEvent extends DetailTaskEvents{
  final ToDoTaskModel toDoTaskModel;
  final String taskTime;

  InProgressTaskEvent({
    required this.toDoTaskModel, required this.taskTime
  });
}
class CompleteTaskEvent extends DetailTaskEvents{
  final ToDoTaskModel toDoTaskModel;
  final String completionTime;

  CompleteTaskEvent({
    required this.toDoTaskModel, required this.completionTime
  });
}

class AddCommentEvent extends DetailTaskEvents{
  String comment;
  String id;
  AddCommentEvent({required this.comment, required this.id});
}

class DetailTaskDataLoadingEvent extends DetailTaskEvents{
  String id;
  DetailTaskDataLoadingEvent({required this.id});
}

