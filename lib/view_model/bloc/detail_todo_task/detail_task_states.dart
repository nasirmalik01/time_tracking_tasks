class  DetailTaskStates{}

class InitialState extends DetailTaskStates{}
class InProgressTaskLoadingState extends DetailTaskStates{}
class CompleteTaskState extends DetailTaskStates{}
class DetailTaskSuccessState extends DetailTaskStates{
  List<dynamic>? commentList;
  int? isDialogOpen;

  DetailTaskSuccessState({
    this.commentList,
    this.isDialogOpen = 1
  });
}
class DetailTaskErrorState extends DetailTaskStates{}
class AddingCommentLoadingState extends DetailTaskStates{}
class DataLoadingState extends DetailTaskStates{}
class CommentAddedState extends DetailTaskStates{}
