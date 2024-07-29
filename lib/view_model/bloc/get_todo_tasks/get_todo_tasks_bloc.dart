import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:take_home_challenge/models/completed_task_model.dart';
import 'package:take_home_challenge/models/todo_task_model.dart';
import 'package:take_home_challenge/network/remote_repositories/todo_task_repo.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/methods/methods.dart';
import 'package:take_home_challenge/view_model/bloc/get_todo_tasks/get_todo_tasks_events.dart';
import 'package:take_home_challenge/view_model/bloc/get_todo_tasks/get_todo_tasks_states.dart';

class GetToDoTasksBloc extends Bloc<GetToDoTasksEvents, GetToDoTasksStates> {
  List<ToDoTaskModel>? toDoTaskList;

  GetToDoTasksBloc() : super(GetToDoTasksLoadingState()) {
    on<GetToDoTasksLoadingEvent>((event, emit) async {
      toDoTaskList = await TodoTaskRepo.getTodoTasksList();

      if (toDoTaskList != null) {
        emit(GetToDoTasksLoadedState(toDoTaskList));
      } else {
        emit(GetToDoTasksErrorState());
      }
    });

    on<DeleteTodoTaskEvent>((event, emit) async {
      try {
        emit(DeleteTodoTaskState());
        await TodoTaskRepo.deleteTodoTask(id: event.id);
      } catch (e) {
        log(e.toString());
      }
      add(GetToDoTasksLoadingEvent());
    });

    on<FinishTodoTaskEvent>((event, emit) async {
      try {
      emit(FinishTodoTaskState());
      await TodoTaskRepo.finishTodoTask(
        id: event.toDoTaskModel.id!,
      );

      String formattedDate = getCurrentDateTime();
      CompletedTaskModel completedTaskModel = CompletedTaskModel(
          id: event.toDoTaskModel.id,
          taskName: event.toDoTaskModel.content,
          taskDesc: event.toDoTaskModel.description ??
              AppStrings.nullCheckErrorMessage,
          dueDate:
              event.toDoTaskModel.due?.date ?? AppStrings.nullCheckErrorMessage,
          priority: event.toDoTaskModel.priorityLevel,
          completionTime: '00:00:00',
          status: AppStrings.completed,
          completionDate: formattedDate,
      );
      FirebaseFirestore.instance
          .collection(AppStrings.completed)
          .add(completedTaskModel.toJson())
          .then((value) {
        add(GetToDoTasksLoadingEvent());
      });
      }
      catch(e){
        print(e.toString());
        emit(GetToDoTasksErrorState());
      }
    });
  }
}
