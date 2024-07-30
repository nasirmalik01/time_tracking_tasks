class InProgressTaskEvents{}

class InProgressTasksLoadingEvent extends InProgressTaskEvents{}
class InProgressDeleteTodoTaskEvent extends InProgressTaskEvents{
  String id;
  InProgressDeleteTodoTaskEvent(this.id);
}
class InProgressFinishTodoEvent extends InProgressTaskEvents{
  dynamic inProgressTaskList;
  InProgressFinishTodoEvent(this.inProgressTaskList);
}