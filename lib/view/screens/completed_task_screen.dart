import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challenge/config/language_constants.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/view/widgets/loader.dart';
import 'package:take_home_challenge/view/widgets/rounded_container.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';
import 'package:take_home_challenge/view_model/bloc/completed_todo_tasks/completed_tasks_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/completed_todo_tasks/completed_tasks_events.dart';
import 'package:take_home_challenge/view_model/bloc/completed_todo_tasks/completed_tasks_states.dart';
import 'package:take_home_challenge/view_model/bloc/get_todo_tasks/get_todo_tasks_states.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CompletedTasksBloc>().add(CompletedTasksLoadingEvent());

    return BlocConsumer<CompletedTasksBloc, CompletedTasksStates>(
      listener: (BuildContext context, CompletedTasksStates state) {},
      builder: (BuildContext context, state) {
        if (state is GetToDoTasksLoadingState) {
          return loadingDataWidget();
        }

        if (state is CompletedTasksLoadedState) {
          return Scaffold(
              body: Padding(
            padding: EdgeInsets.only(
              top: sizes.height * 0.02,
              left: sizes.width * 0.03,
              right: sizes.width * 0.03,
            ),
            child: ListView.builder(
                itemCount: state.completedTaskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: sizes.height * 0.02),
                    child: roundedContainer(
                        widget: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizes.width * 0.03,
                        vertical: sizes.height * 0.01,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: sizes.width * 0.5,
                                child: TextView.title(
                                    text:
                                        state.completedTaskList?[index]['task_name'] ??
                                            translation(context).nullCheckErrorMessage,
                                    textSize: sizes.fontSize20,
                                    font: Fonts.poppinsSemiBold,
                                    textAlign: TextAlign.start),
                              ),
                              Column(
                                children: [
                                  TextView.title(
                                      text: translation(context).timeSpent,
                                      textSize: sizes.fontSize16,
                                      color: AppColors.blackColor),
                                  TextView.title(
                                      text: state.completedTaskList?[index]['completion_time'],
                                      textSize: sizes.fontSize16,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              roundedContainer(
                                  borderRadius: sizes.height * 0.4,
                                  backgroundColor: state.completedTaskList?[index]['color'],
                                  borderColor: AppColors.pureWhiteColor,
                                  widget: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: sizes.width * 0.04,
                                      vertical: sizes.height * 0.005,
                                    ),
                                    child: TextView.title(
                                        text: state.completedTaskList?[index]['priority'] ??
                                            AppStrings.normal,
                                        textSize: sizes.fontSize16,
                                        color: AppColors.pureWhiteColor),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start ,
                                children: [
                                  TextView.title(
                                    text:  translation(context).completedOn,
                                    textSize: sizes.fontSize16,
                                  ),
                                  TextView.title(
                                    text:  '${state.completedTaskList![index]['completion_date']}',
                                    textSize: sizes.fontSize16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sizes.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: sizes.width * 0.5,
                                    child: TextView.title(
                                      textAlign: TextAlign.start,
                                      text:  translation(context).dueDate,
                                      textSize: sizes.fontSize16,
                                    ),
                                  ),
                                  TextView.title(
                                      text:
                                          state.completedTaskList?[index]['due_date'] ??
                                              translation(context).nullCheckErrorMessage,
                                      textSize: sizes.fontSize16),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  context.read<CompletedTasksBloc>().add(DeleteTodoTaskEvent(
                                    state.completedTaskList![index]['id']
                                  ));
                                },
                                child: roundedContainer(
                                    backgroundColor: AppColors.redColor,
                                    borderColor: AppColors.pureWhiteColor,
                                    widget: Padding(
                                      padding:  EdgeInsets.symmetric(
                                          horizontal: sizes.width * 0.05,
                                          vertical: sizes.width * 0.012,
                                      ),
                                      child: TextView.title(
                                          text: translation(context).remove,
                                          textSize: sizes.fontSize16,
                                          color: AppColors.pureWhiteColor,

                                      ),
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: sizes.height * 0.015,
                          ),
                        ],
                      ),
                    )),
                  );
                }),
          ));
        }
        return Container();
      },
    );
  }
}
