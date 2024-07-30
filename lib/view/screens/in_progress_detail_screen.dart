import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:take_home_challenge/config/language_constants.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/helper_methods/snackbar.dart';
import 'package:take_home_challenge/utils/methods/showDialog.dart';
import 'package:take_home_challenge/view/widgets/add_comment_widget.dart';
import 'package:take_home_challenge/view/widgets/button.dart';
import 'package:take_home_challenge/view/widgets/comment_widget.dart';
import 'package:take_home_challenge/view/widgets/comments_widget.dart';
import 'package:take_home_challenge/view/widgets/icon_widget.dart';
import 'package:take_home_challenge/view/widgets/loader.dart';
import 'package:take_home_challenge/view/widgets/rounded_container.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_detail_task/in_progress_detail_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_detail_task/in_progress_detail_events.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_detail_task/in_progress_detail_states.dart';

class InProgressDetailTaskScreen extends StatefulWidget {
  final dynamic toDoTaskModel;
  const InProgressDetailTaskScreen({this.toDoTaskModel,super.key});

  @override
  State<InProgressDetailTaskScreen> createState() => _InProgressDetailTaskScreenState();
}

class _InProgressDetailTaskScreenState extends State<InProgressDetailTaskScreen> {
  String completionTime = AppStrings.timerInitialValue;
  final TextEditingController commentController = TextEditingController();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    context.read<InProgressDetailBloc>().add(
        DetailTaskDataLoadingEvent(id: widget.toDoTaskModel['id']));

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: BlocConsumer<InProgressDetailBloc, InProgressDetailStates>(
          listener: (BuildContext context, state) {

            switch(state){
              case CompleteTaskState():
                showLoaderDialog(
                    context,
                    title: translation(context).finishingTask
                );
                break;

              case InProgressTaskLoadingState():
                showLoaderDialog(
                    context,
                    title: translation(context).savingTask
                );
                break;

              case AddingCommentLoadingState():
                showLoaderDialog(
                    context,
                    title: translation(context).savingComment
                );
                break;

              case CommentAddedState():
                commentController.clear();
                showSnackBar(context, message: translation(context).commentAdded);
                Navigator.pop(context);
                break;

            }

            if(state is DetailTaskSuccessState){
              if(state.isDialogOpen == 1){

              }
              else if (state.isDialogOpen == 2){
                Navigator.pop(context);
                commentController.clear();
                showSnackBar(context, message: translation(context).commentAdded);
              }
              else {
                Navigator.pop(context);
                Navigator.pop(context, false);
              }
            }
          },
          builder: (BuildContext context, Object? state) {
            if(state is DataLoadingState){
              return Center(child: loadingDataWidget());
            }

            if(state is DetailTaskSuccessState){
              return Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: sizes.width * 0.04),
                    child: Column(
                      children: [
                        SizedBox(height: sizes.height * 0.07,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: iconWidget(
                                  icon: Icons.arrow_back_ios_new_outlined,
                                  color: AppColors.blackColor,
                                  size: sizes.height * 0.03
                              ),
                            ),
                            SizedBox(width: sizes.width * 0.03,),
                            SizedBox(
                              width: sizes.width * 0.8,
                              child: TextView.title(
                                text: widget.toDoTaskModel['task_name'],
                                textSize: sizes.fontSize16,
                                font: Fonts.poppinsRegular,

                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: sizes.height * 0.17,),
                        StreamBuilder<int>(
                          stream: _stopWatchTimer.rawTime,
                          initialData: _stopWatchTimer.rawTime.value,
                          builder: (context, snap) {
                            final value = snap.data!;
                            final displayTime =
                            StopWatchTimer.getDisplayTime(value, hours: false);

                            completionTime = displayTime;
                            return Column(
                              children: <Widget>[
                                Center(
                                  child: TextView.title(
                                      text: displayTime,
                                      textSize: sizes.fontSize35 + sizes.fontSize20,
                                      color: AppColors.blackColor,
                                      font: Fonts.poppinsSemiBold
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: sizes.height * 0.02,),
                        GestureDetector(
                          onTap: (){
                            if(_stopWatchTimer.isRunning){
                              _stopWatchTimer.onStopTimer();
                            }
                            else{
                              _stopWatchTimer.onStartTimer();
                            }
                            setState(() {});
                          },
                          child: CircleAvatar(
                              radius: sizes.height * 0.06,
                              backgroundColor: AppColors.normalPriorityColor,
                              child: iconWidget(
                                icon: _stopWatchTimer.isRunning
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: sizes.height * 0.08,
                                color: AppColors.pureWhiteColor,

                              )
                          ),
                        ),
                        SizedBox(height: sizes.height * 0.1,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Button(
                              onPress:  (){
                                _stopWatchTimer.onStopTimer();
                                context.read<InProgressDetailBloc>().add(
                                    InProgressDetailTaskEvent(
                                        toDoTaskModel: widget.toDoTaskModel,
                                        taskTime: completionTime
                                    )
                                );

                              },
                              width: sizes.width * 0.4,
                              btnColor: AppColors.pinkColor,
                              text: translation(context).save,
                              textSize: sizes.fontSize18,
                            ),
                            Button(
                              onPress:  (){
                                _stopWatchTimer.onStopTimer();
                                context.read<InProgressDetailBloc>().add(
                                    CompleteTaskEvent(
                                        toDoTaskModel: widget.toDoTaskModel,
                                        completionTime: completionTime
                                    )
                                );
                              },
                              width: sizes.width * 0.4,
                              btnColor: AppColors.pinkColor,
                              text: translation(context).finish,
                              textSize: sizes.fontSize18,
                            ),
                          ],
                        ),
                        SizedBox(height: sizes.height * 0.05,),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return CommentsWidget(
                                    widget: ListView.builder(
                                      itemCount: state.commentList?.length ?? 0,
                                      itemBuilder: (BuildContext context, int index) {
                                        return commentWidget(comment: state.commentList![index]['comment']);
                                      },
                                    )
                                );
                              },
                            );
                          },
                          child: roundedContainer(
                              widget: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: sizes.width * 0.1,
                                  vertical: sizes.height * 0.02,
                                ),
                                child: TextView.title(
                                    text: translation(context).tapToSeeComments,
                                    textSize: sizes.fontSize16
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AddCommentWidget(
                      controller: commentController,
                      onPress: (){
                        if(commentController.text == ''){
                          return showSnackBar(
                              context, message: translation(context).emptyCommentErrorMessage);
                        }
                        context.read<InProgressDetailBloc>().add(
                            AddCommentEvent(
                                comment: commentController.text,
                                id: widget.toDoTaskModel['id']
                            )
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return Container();
          }
      ),
    );
  }
}