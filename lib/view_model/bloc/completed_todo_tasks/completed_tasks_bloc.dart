import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challenge/models/completed_task_model.dart';
import 'package:take_home_challenge/network/remote_repositories/completed_task_repo.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/view_model/bloc/completed_todo_tasks/completed_tasks_events.dart';
import 'package:take_home_challenge/view_model/bloc/completed_todo_tasks/completed_tasks_states.dart';

class CompletedTasksBloc extends Bloc<CompletedTasksEvents, CompletedTasksStates> {
  List<dynamic>? completedTaskList;

  CompletedTasksBloc() : super(CompletedTasksLoadingState()) {
    on<CompletedTasksLoadingEvent>((event, emit) async {
      try {
        completedTaskList = await InProgressAndCompletedTasksRepo.getTasks();
        emit(CompletedTasksLoadedState(completedTaskList));
      }
      catch(e){
        emit(CompletedTasksErrorState());
      }
    });

    on<DeleteTodoTaskEvent>((event, emit) async {
      try{
        String docId = '';
        dynamic collectionRef = FirebaseFirestore.instance.collection(AppStrings.completed);
        dynamic querySnapshot = await collectionRef.get();
        for (dynamic doc in querySnapshot.docs) {
          if(doc.data()['id'] == event.id){
            docId = doc.id.toString();
          }
        }
        await collectionRef.doc(docId).delete();
        add(CompletedTasksLoadingEvent());
      }
      catch(e){
        emit(CompletedTasksErrorState());
      }
    });

  }
}
