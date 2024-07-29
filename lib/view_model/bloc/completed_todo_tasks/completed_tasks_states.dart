
class CompletedTasksStates {}

class CompletedTasksLoadingState extends CompletedTasksStates {}

class CompletedTasksLoadedState extends CompletedTasksStates {
  List<dynamic>? completedTaskList;
  CompletedTasksLoadedState(this.completedTaskList);
}

class CompletedTasksErrorState extends CompletedTasksStates {}

class DeleteTodoTaskState extends CompletedTasksStates {}

