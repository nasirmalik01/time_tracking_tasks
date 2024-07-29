
class CompletedTasksEvents{}

class CompletedTasksLoadingEvent extends CompletedTasksEvents{}
class CompletedTasksLoadedEvent extends CompletedTasksEvents{}
class CompletedTasksErrorEvent extends CompletedTasksEvents{}
class DeleteTodoTaskEvent extends CompletedTasksEvents{
  String id;
  DeleteTodoTaskEvent(this.id);
}