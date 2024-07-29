import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challenge/network/remote_repositories/add_new_task_repo.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/helper_methods/snackbar.dart';
import 'package:take_home_challenge/view_model/bloc/add_new_task/add_new_task_events.dart';
import 'package:take_home_challenge/view_model/bloc/add_new_task/add_new_task_states.dart';


class AddNewTodoTaskBloc extends Bloc<AddNewToDoTasksEvents, AddNewTodoTaskStates> {

  AddNewTodoTaskBloc() : super(InitialState()) {
    on<AddNewTodoTaskLoadingEvent>((event, emit) async {
      if(event.title == ''){
        return showSnackBar(event.context,
            message: AppStrings.fillName);
      }
      emit(AddNewTodoTaskLoadingState());
      int priority = getPriorityNumber(priority: event.taskPriority);
      try{
        await AddNewTaskRepo.createNewTask({
          AppStrings.content: event.title,
          AppStrings.description: event.desc,
          AppStrings.priority: priority,
          AppStrings.dueString: event.selectedDate
        });

        emit(AddNewTodoTaskSuccessState());
      }
      catch(e){
        emit(AddNewTodoTaskErrorState());
      }
    });
    on<InitialEvent>((event, emit) async {
      emit(InitialState());
    });
  }

 static int getPriorityNumber({required String priority}){
    int priorityNumber = 1;
    switch(priority){
      case AppStrings.normal:
        priorityNumber =  1;
        break;
      case AppStrings.notImportant:
        priorityNumber = 2;
        break;
      case AppStrings.important:
        priorityNumber = 3;
        break;
      case AppStrings.urgent:
        priorityNumber = 4;
        break;
    }
    return priorityNumber;
  }
}
