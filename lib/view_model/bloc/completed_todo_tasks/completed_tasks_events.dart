
class CompletedTasksEvents{}

class CompletedTasksLoadingEvent extends CompletedTasksEvents{}
class DeleteTodoTaskEvent extends CompletedTasksEvents{
  String id;
  DeleteTodoTaskEvent(this.id);
}