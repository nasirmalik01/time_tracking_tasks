import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challenge/models/completed_task_model.dart';
import 'package:take_home_challenge/network/remote_repositories/completed_task_repo.dart';
import 'package:take_home_challenge/network/remote_repositories/todo_task_repo.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/methods/methods.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_task/in_progress_task_events.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_task/in_progress_task_states.dart';

class InProgressTasksBloc extends Bloc<InProgressTaskEvents, InProgressTasksStates> {
  List<dynamic>? inProgressTasksList;

  InProgressTasksBloc() : super(InProgressTasksLoadingState()) {
    on<InProgressTasksLoadingEvent>((event, emit) async {
      try {
        inProgressTasksList = await InProgressAndCompletedTasksRepo.getTasks(
          docId: AppStrings.inProgressDocId
        );
        emit(InProgressTasksLoadedState(inProgressTasksList));
      }
      catch(e){
        emit(InProgressTasksErrorState());
      }
    });

    on<InProgressDeleteTodoTaskEvent>((event, emit) async {
      try{
        String docId = '';
        dynamic collectionRef = FirebaseFirestore.instance.collection(
            AppStrings.inProgressDocId);
        dynamic querySnapshot = await collectionRef.get();
        for (dynamic doc in querySnapshot.docs) {
          if(doc.data()['id'] == event.id){
            docId = doc.id.toString();
          }
        }
        await collectionRef.doc(docId).delete();
        add(InProgressTasksLoadingEvent());
      }
      catch(e){
        emit(InProgressTasksErrorState());
      }
    });


    on<InProgressFinishTodoEvent>((event, emit) async {
      // return;

        emit(InProgressFinishTaskState());
        // await TodoTaskRepo.finishTodoTask(
        //   id: event.inProgressTaskList!['id']!
        // );

        String formattedDate = getCurrentDateTime();

        CompletedTaskModel completedTaskModel = CompletedTaskModel(
          id: event.inProgressTaskList!['id'],
          taskName: event.inProgressTaskList!['task_name'],
          taskDesc: event.inProgressTaskList!['task_desc'] ??
              AppStrings.nullCheckErrorMessage,
          dueDate:
          event.inProgressTaskList!['due_date'] ?? AppStrings.nullCheckErrorMessage,
          priority: event.inProgressTaskList!['priority'],
          completionTime: event.inProgressTaskList!['completion_time'],
          status: event.inProgressTaskList!['status'],
          completionDate: formattedDate,
        );
        await FirebaseFirestore.instance
            .collection(AppStrings.completed)
            .add(completedTaskModel.toJson());

      String docId = '';
      dynamic collectionRef = FirebaseFirestore.instance.collection(
          AppStrings.inProgressDocId);
      dynamic querySnapshot = await collectionRef.get();
      for (dynamic doc in querySnapshot.docs) {
        if(doc.data()['id'] == event.inProgressTaskList!['id']){
          docId = doc.id.toString();
        }
      }
      await collectionRef.doc(docId).delete();
        emit(InProgressSuccessTaskState());
        add(InProgressTasksLoadingEvent());

    });

  }
}
