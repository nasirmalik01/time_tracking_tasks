class InProgressTasksStates {}

class InProgressTasksLoadingState extends InProgressTasksStates {}

class InProgressTasksLoadedState extends InProgressTasksStates {
  List<dynamic>? inProgressTaskList;
  InProgressTasksLoadedState(this.inProgressTaskList);
}

class InProgressTasksErrorState extends InProgressTasksStates {}
class InProgressFinishTaskState extends InProgressTasksStates {}
class InProgressSuccessTaskState extends InProgressTasksStates {}

