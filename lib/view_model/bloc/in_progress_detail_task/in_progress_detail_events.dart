class  InProgressDetailEvents{}

class InProgressDetailTaskEvent extends InProgressDetailEvents{
  final dynamic toDoTaskModel;
  final String taskTime;

  InProgressDetailTaskEvent({
    required this.toDoTaskModel, required this.taskTime
  });
}
class CompleteTaskEvent extends InProgressDetailEvents{
  final dynamic toDoTaskModel;
  final String completionTime;

  CompleteTaskEvent({
    required this.toDoTaskModel, required this.completionTime
  });
}

class AddCommentEvent extends InProgressDetailEvents{
  String comment;
  String id;
  AddCommentEvent({required this.comment, required this.id});
}

class DetailTaskDataLoadingEvent extends InProgressDetailEvents{
  String id;
  DetailTaskDataLoadingEvent({required this.id});
}

