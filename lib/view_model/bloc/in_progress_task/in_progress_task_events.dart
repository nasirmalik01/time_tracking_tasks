class InProgressTaskEvents{}

class InProgressTasksLoadingEvent extends InProgressTaskEvents{}
class InProgressTasksLoadedEvent extends InProgressTaskEvents{}
class InProgressTasksErrorEvent extends InProgressTaskEvents{}
class InProgressDeleteTodoTaskEvent extends InProgressTaskEvents{
  String id;
  InProgressDeleteTodoTaskEvent(this.id);
}
class InProgressFinishTodoEvent extends InProgressTaskEvents{
  dynamic inProgressTaskList;
  InProgressFinishTodoEvent(this.inProgressTaskList);
}