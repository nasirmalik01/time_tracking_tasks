import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/methods/showDialog.dart';
import 'package:take_home_challenge/view/screens/in_progress_detail_screen.dart';
import 'package:take_home_challenge/view/widgets/loader.dart';
import 'package:take_home_challenge/view/widgets/rounded_container.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_task/in_progress_task_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_task/in_progress_task_events.dart';
import 'package:take_home_challenge/view_model/bloc/in_progress_task/in_progress_task_states.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InProgressTasksBloc, InProgressTasksStates>(
      listener: (BuildContext context, InProgressTasksStates state) {
        if(state is InProgressFinishTaskState){
          showLoaderDialog(context, title: AppStrings.finishingTask);
        }

        if(state is InProgressSuccessTaskState){
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, state) {
        context.read<InProgressTasksBloc>().add(InProgressTasksLoadingEvent());

        if (state is InProgressTasksLoadingState) {
          return loadingDataWidget();
        }

        if(state is InProgressTasksLoadedState){
          return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                  top: sizes.height * 0.02,
                  left: sizes.width * 0.03,
                  right: sizes.width * 0.03,
                ),
                child: ListView.builder(
                    itemCount: state.inProgressTaskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => InProgressDetailTaskScreen(
                                toDoTaskModel: state.inProgressTaskList![index],
                              )));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: sizes.height * 0.02),
                          child: roundedContainer(
                              widget: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: sizes.width * 0.03,
                                  vertical: sizes.height * 0.01,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: sizes.width * 0.5,
                                          child: TextView.title(
                                              text:
                                              state.inProgressTaskList?[index]['task_name'] ??
                                                  AppStrings.nullCheckErrorMessage,
                                              textSize: sizes.fontSize20,
                                              font: Fonts.poppinsSemiBold,
                                              textAlign: TextAlign.start),
                                        ),
                                        Row(
                                          children: [
                                            TextView.title(
                                                text: AppStrings.onGoing,
                                                textSize: sizes.fontSize14,
                                                color: AppColors.blackColor),
                                            TextView.title(
                                                text: state.inProgressTaskList?[index]['completion_time'],
                                                textSize: sizes.fontSize14,
                                                color: AppColors.blackColor,
                                                font: Fonts.poppinsSemiBold
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: sizes.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        roundedContainer(
                                            borderRadius: sizes.height * 0.4,
                                            backgroundColor: state.inProgressTaskList?[index]['color']
                                                      ?? AppColors.normalPriorityColor,
                                            borderColor: AppColors.pureWhiteColor,
                                            widget: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: sizes.width * 0.04,
                                                vertical: sizes.height * 0.005,
                                              ),
                                              child: TextView.title(
                                                  text:state.inProgressTaskList?[index]['priority'] ??
                                                      AppStrings.normal,
                                                  textSize: sizes.fontSize16,
                                                  color: AppColors.pureWhiteColor),
                                            )),
                                        TextView.title(
                                          text: AppStrings.inProgress,
                                          textSize: sizes.fontSize16,),

                                      ],
                                    ),
                                    SizedBox(
                                      height: sizes.height * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TextView.title(
                                              text:  AppStrings.dueDate,
                                              textSize: sizes.fontSize16,
                                            ),
                                            TextView.title(
                                                text:
                                                state.inProgressTaskList?[index]['due_date'] ??
                                                    AppStrings.nullCheckErrorMessage,
                                                textSize: sizes.fontSize16),
                                          ],
                                        ),
                                        Row(
                                          children: [

                                            GestureDetector(
                                              onTap: () async {
                                                context.read<InProgressTasksBloc>().add(
                                                  InProgressFinishTodoEvent(state.inProgressTaskList?[index])
                                                );
                                              },
                                              child: roundedContainer(
                                                  backgroundColor: AppColors.cyanColor,
                                                  borderColor: AppColors.pureWhiteColor,
                                                  widget: Padding(
                                                    padding:  EdgeInsets.symmetric(
                                                      horizontal: sizes.width * 0.06,
                                                      vertical: sizes.width * 0.012,
                                                    ),
                                                    child: TextView.title(
                                                      text: AppStrings.finish,
                                                      textSize: sizes.fontSize16,
                                                      color: AppColors.pureWhiteColor,

                                                    ),
                                                  )),
                                            ),
                                            SizedBox(width: sizes.width * 0.01,),
                                            GestureDetector(
                                              onTap: () async {
                                                context.read<InProgressTasksBloc>().add(
                                                  InProgressDeleteTodoTaskEvent(state.inProgressTaskList?[index]['id'])
                                                );
                                              },
                                              child: roundedContainer(
                                                  backgroundColor: AppColors.redColor,
                                                  borderColor: AppColors.pureWhiteColor,
                                                  widget: Padding(
                                                    padding:  EdgeInsets.symmetric(
                                                      horizontal: sizes.width * 0.03,
                                                      vertical: sizes.width * 0.012,
                                                    ),
                                                    child: TextView.title(
                                                      text: AppStrings.remove,
                                                      textSize: sizes.fontSize16,
                                                      color: AppColors.pureWhiteColor,

                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    SizedBox(
                                      height: sizes.height * 0.015,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
              )
          );
        }
        return Container();
      },
    );
  }
}
