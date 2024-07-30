class  InProgressDetailStates{}

class InitialState extends InProgressDetailStates{}
class InProgressTaskState extends InProgressDetailStates{}
class InProgressTaskLoadingState extends InProgressDetailStates{}
class CompleteTaskState extends InProgressDetailStates{}
class DetailTaskSuccessState extends InProgressDetailStates{
  List<dynamic>? commentList;
  int? isDialogOpen;

  DetailTaskSuccessState({
    this.commentList,
    this.isDialogOpen = 1
  });
}
class DetailTaskErrorState extends InProgressDetailStates{}
class AddingCommentLoadingState extends InProgressDetailStates{}
class DataLoadedState extends InProgressDetailStates{
}
class DataLoadingState extends InProgressDetailStates{}
class CommentAddedState extends InProgressDetailStates{}
