import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/methods/showDialog.dart';
import 'package:take_home_challenge/view/screens/add_new_task_screen.dart';
import 'package:take_home_challenge/view/screens/detail_task_screen.dart';
import 'package:take_home_challenge/view/screens/update_task_screen.dart';
import 'package:take_home_challenge/view/widgets/floating_action_button.dart';
import 'package:take_home_challenge/view/widgets/icon_widget.dart';
import 'package:take_home_challenge/view/widgets/loader.dart';
import 'package:take_home_challenge/view/widgets/rounded_container.dart';
import 'package:take_home_challenge/view/widgets/task_icon_widget.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';
import 'package:take_home_challenge/view_model/bloc/get_todo_tasks/get_todo_tasks_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/get_todo_tasks/get_todo_tasks_events.dart';
import 'package:take_home_challenge/view_model/bloc/get_todo_tasks/get_todo_tasks_states.dart';

class ToDoTaskScreen extends StatelessWidget {
  ToDoTaskScreen({super.key});

  bool isOpenDialog = false;

  @override
  Widget build(BuildContext context) {
    isOpenDialog = false;
    context.read<GetToDoTasksBloc>().add(GetToDoTasksLoadingEvent());

    return BlocConsumer<GetToDoTasksBloc, GetToDoTasksStates>(
      listener: (BuildContext context, GetToDoTasksStates state) {
        String loadingTitle = '';
        if (state is DeleteTodoTaskState || state is FinishTodoTaskState) {
          if (state is DeleteTodoTaskState) {
            loadingTitle = AppStrings.deletingTask;
          } else {
            loadingTitle = AppStrings.finishingTask;
          }
          isOpenDialog = true;
          showLoaderDialog(context, title: loadingTitle);
        }

        if (state is GetToDoTasksLoadedState) {
          if (isOpenDialog == true) {
            Navigator.pop(context);
          }
        }
      },
      builder: (BuildContext context, state) {
        if (state is GetToDoTasksLoadingState) {
          return loadingDataWidget();
        }

        if (state is GetToDoTasksLoadedState) {
          return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                  top: sizes.height * 0.02,
                  left: sizes.width * 0.03,
                  right: sizes.width * 0.03,
                ),
                child: ListView.builder(
                    itemCount: state.toDoTaskList!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: sizes.height * 0.02),
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailTaskScreen(
                                          toDoTaskModel:
                                              state.toDoTaskList![index],
                                        )));
                            isOpenDialog = false;
                            context
                                .read<GetToDoTasksBloc>()
                                .add(GetToDoTasksLoadingEvent());
                          },
                          child: roundedContainer(
                              widget: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: sizes.width * 0.03,
                              vertical: sizes.height * 0.01,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(left: sizes.width * 0.02),
                                  width: sizes.width * 0.7,
                                  child: TextView.title(
                                      text:
                                          state.toDoTaskList?[index].content ??
                                              AppStrings.nullCheckErrorMessage,
                                      textSize: sizes.fontSize20,
                                      font: Fonts.poppinsSemiBold,
                                      textAlign: TextAlign.start),
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
                                        backgroundColor: state
                                                .toDoTaskList?[index]
                                                .priorityColor ??
                                            AppColors.normalPriorityColor,
                                        borderColor: AppColors.pureWhiteColor,
                                        widget: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: sizes.width * 0.04,
                                            vertical: sizes.height * 0.005,
                                          ),
                                          child: TextView.title(
                                              text: state.toDoTaskList?[index]
                                                      .priorityLevel ??
                                                  '',
                                              textSize: sizes.fontSize16,
                                              color: AppColors.pureWhiteColor),
                                        )),
                                    TextView.title(
                                      text: AppStrings.pending,
                                      textSize: sizes.fontSize16,
                                    ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView.title(
                                          text: AppStrings.dueDate,
                                          textSize: sizes.fontSize16,
                                        ),
                                        SizedBox(
                                          width: sizes.width * 0.02,
                                        ),
                                        TextView.title(
                                            text: state.toDoTaskList![index].due
                                                    ?.date ??
                                                AppStrings
                                                    .nullCheckErrorMessage,
                                            textSize: sizes.fontSize16)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        taskIconWidget(
                                          onTap: () async {
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateTaskScreen(
                                                          toDoTaskModel: state
                                                                  .toDoTaskList![
                                                              index],
                                                        )));
                                            isOpenDialog = false;
                                            context
                                                .read<GetToDoTasksBloc>()
                                                .add(
                                                    GetToDoTasksLoadingEvent());
                                          },
                                          icon: Icons.mode_edit_outlined,
                                          color: AppColors.normalPriorityColor,
                                        ),
                                        SizedBox(
                                          width: sizes.width * 0.01,
                                        ),
                                        taskIconWidget(
                                          onTap: () {
                                            context
                                                .read<GetToDoTasksBloc>()
                                                .add(DeleteTodoTaskEvent(
                                                  state
                                                      .toDoTaskList![index].id!,
                                                ));
                                          },
                                          icon: Icons.delete,
                                          color: AppColors.redColor,
                                        ),
                                        SizedBox(
                                          width: sizes.width * 0.01,
                                        ),
                                        taskIconWidget(
                                            onTap: () {
                                              context
                                                  .read<GetToDoTasksBloc>()
                                                  .add(FinishTodoTaskEvent(state
                                                      .toDoTaskList![index]));
                                            },
                                            isFinish: true,
                                            color: Colors.cyan),
                                      ],
                                    )
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
              ),
              floatingActionButton: extendedFAB(onPress: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddNewTaskScreen()));
                isOpenDialog = false;
                context
                    .read<GetToDoTasksBloc>()
                    .add(GetToDoTasksLoadingEvent());
              }));
        }
        return Container();
      },
    );
  }
}
