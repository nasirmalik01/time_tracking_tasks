import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:take_home_challenge/models/completed_task_model.dart';
import 'package:take_home_challenge/network/remote_repositories/detail_task_repo.dart';
import 'package:take_home_challenge/network/remote_repositories/todo_task_repo.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/helper_methods/snackbar.dart';
import 'package:take_home_challenge/utils/methods/methods.dart';
import 'package:take_home_challenge/view_model/bloc/detail_timer_task/detail_task_events.dart';
import 'package:take_home_challenge/view_model/bloc/detail_timer_task/detail_task_states.dart';

class DetailTaskBloc extends Bloc<DetailTaskEvents, DetailTaskStates> {
  List<dynamic>? commentList = [];

  DetailTaskBloc() : super(InitialState()) {
    on<InProgressTaskEvent>((event, emit) async {
        try {
          emit(InProgressTaskLoadingState());
          await TodoTaskRepo.deleteTodoTask(id: event.toDoTaskModel.id!);

          String formattedDate = getCurrentDateTime();
          CompletedTaskModel completedTaskModel = CompletedTaskModel(
            id: event.toDoTaskModel.id,
            taskName: event.toDoTaskModel.content,
            taskDesc: event.toDoTaskModel.description ??
                AppStrings.nullCheckErrorMessage,
            dueDate:
            event.toDoTaskModel.due?.date ?? AppStrings.nullCheckErrorMessage,
            priority: event.toDoTaskModel.priorityLevel,
            completionTime: event.taskTime,
            status: AppStrings.inProgressDocId,
            completionDate: formattedDate,
          );
          await FirebaseFirestore.instance
              .collection(AppStrings.inProgressDocId)
              .add(completedTaskModel.toJson());
          emit(DetailTaskSuccessState(
            isDialogOpen: 3
          ));

        } catch (e) {
          print(e.toString());
        }
    });

    on<CompleteTaskEvent>((event, emit) async {
        try {
          emit(CompleteTaskState());
          await TodoTaskRepo.finishTodoTask(
            id: event.toDoTaskModel.id!,
          );

          DateTime dateTime = DateTime.now();
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

          CompletedTaskModel completedTaskModel = CompletedTaskModel(
            id: event.toDoTaskModel.id,
            taskName: event.toDoTaskModel.content,
            taskDesc: event.toDoTaskModel.description ??
                AppStrings.nullCheckErrorMessage,
            dueDate:
            event.toDoTaskModel.due?.date ?? AppStrings.nullCheckErrorMessage,
            priority: event.toDoTaskModel.priorityLevel,
            completionTime: event.completionTime,
            status: AppStrings.completed,
            completionDate: formattedDate,
          );
         await FirebaseFirestore.instance
              .collection(AppStrings.completed)
              .add(completedTaskModel.toJson());
          emit(DetailTaskSuccessState(
            isDialogOpen: 3
          ));
        }
        catch(e){
          print(e.toString());
          emit(DetailTaskErrorState());
        }
    });

    on<AddCommentEvent>((event, emit) async {
        try {
          emit(AddingCommentLoadingState());
          await FirebaseFirestore.instance
              .collection('${AppStrings.comments} ${event.id}')
              .add({
            AppStrings.comment : event.comment
          });
          emit(DetailTaskSuccessState(
              // commentList: commentList ?? [],
              isDialogOpen: 2
          ),);
          add(DetailTaskDataLoadingEvent(
            id: event.id
          ));
      }
      catch(e){
        print(e);
      }
    });

    on<DetailTaskDataLoadingEvent>((event, emit) async {
      try {
        emit(DataLoadingState());
        commentList = await DetailTaskRepo.getComments(
            id: '${AppStrings.comments} ${event.id}');
        emit(DetailTaskSuccessState(
            commentList: commentList ?? [],
            isDialogOpen: 1
        ),);
      }
      catch(e){
        emit(DetailTaskErrorState());
      }
    });
  }
}
