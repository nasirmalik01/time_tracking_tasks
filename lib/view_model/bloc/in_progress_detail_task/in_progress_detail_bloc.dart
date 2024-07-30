import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:take_home_challenge/models/completed_task_model.dart';
import 'package:take_home_challenge/network/remote_repositories/detail_task_repo.dart';
import 'package:take_home_challenge/network/remote_repositories/todo_task_repo.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/methods/methods.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_detail_task/in_progress_detail_events.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_detail_task/in_progress_detail_states.dart';

class InProgressDetailBloc extends Bloc<InProgressDetailEvents, InProgressDetailStates> {
  List<dynamic>? commentList = [];

  InProgressDetailBloc() : super(InitialState()) {

    /// For getting document id
    Future<String> getDocId(String id) async {
      String docId = '';
      dynamic collectionRef = FirebaseFirestore.instance.collection(AppStrings.inProgressDocId);
      dynamic querySnapshot = await collectionRef.get();
      for (dynamic doc in querySnapshot.docs) {
        if(doc.data()['id'] == id){
          docId = doc.id.toString();
        }
      }
      return docId;
    }

    on<InProgressDetailTaskEvent>((event, emit) async {
      try {
        emit(InProgressTaskLoadingState());
        await TodoTaskRepo.deleteTodoTask(id: event.toDoTaskModel['id']);

        String formattedDate = getCurrentDateTime();
        CompletedTaskModel completedTaskModel = CompletedTaskModel(
          id: event.toDoTaskModel['id'],
          taskName: event.toDoTaskModel['task_name'],
          taskDesc: event.toDoTaskModel['task_desc'] ??
              AppStrings.nullCheckErrorMessage,
          dueDate: event.toDoTaskModel['due_date']??
              AppStrings.nullCheckErrorMessage,
          priority: event.toDoTaskModel['priority'],
          completionTime: event.taskTime,
          status: AppStrings.inProgressDocId,
          completionDate: formattedDate,
        );

        String docId = await getDocId(event.toDoTaskModel['id']);

        await FirebaseFirestore.instance
            .collection(AppStrings.inProgressDocId)
            .doc(docId).set(completedTaskModel.toJson());
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
          id: event.toDoTaskModel['id'],
        );

        DateTime dateTime = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

        CompletedTaskModel completedTaskModel = CompletedTaskModel(
          id: event.toDoTaskModel['id'],
          taskName: event.toDoTaskModel['task_name'],
          taskDesc: event.toDoTaskModel['task_desc'] ??
              AppStrings.nullCheckErrorMessage,
          dueDate: event.toDoTaskModel['due_date'] ??
              AppStrings.nullCheckErrorMessage,
          priority: event.toDoTaskModel['priority'],
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
