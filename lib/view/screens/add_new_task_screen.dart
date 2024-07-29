import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/view/widgets/button.dart';
import 'package:take_home_challenge/view/widgets/icon_widget.dart';
import 'package:take_home_challenge/view/widgets/priority_container_widget.dart';
import 'package:take_home_challenge/view/widgets/rounded_container.dart';
import 'package:take_home_challenge/view/widgets/textfield.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';
import 'package:take_home_challenge/view_model/bloc/add_new_task/add_new_task_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/add_new_task/add_new_task_events.dart';
import 'package:take_home_challenge/view_model/bloc/add_new_task/add_new_task_states.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  String priorityLevel = '';
  String formattedDate = '';
  bool isDateSelected = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<AddNewTodoTaskBloc>().add(InitialEvent());
    updatePriorityLevel(String priority){
      setState(() {
        priorityLevel = priority;
      });
    }

    selectDate() async {
      DateTime selectedDate = DateTime.now();
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: selectedDate,
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          isDateSelected = true;
          formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        });
      }
    }

    return Scaffold(
      body: BlocConsumer<AddNewTodoTaskBloc, AddNewTodoTaskStates>(
        listener: (BuildContext context, AddNewTodoTaskStates state) {
          if(state is AddNewTodoTaskSuccessState){
            Navigator.pop(context, false);
          }
        },
        builder: (BuildContext context, state) {
          if(state is InitialState){
            return SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(
                    horizontal: sizes.width * 0.04
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        TextView.title(
                            text: AppStrings.newTask,
                            textSize: sizes.fontSize18,
                            font: Fonts.poppinsSemiBold
                        )
                      ],
                    ),
                    SizedBox(height: sizes.height * 0.04,),
                    TextFieldWidget(
                      textEditingController: titleController,
                      bgColor: AppColors.lightGrey,
                      hint: AppStrings.enterTitle,
                      borderColor: AppColors.greyColor.withOpacity(0.3),
                    ),
                    SizedBox(height: sizes.height * 0.02,),
                    TextFieldWidget(
                      textEditingController: descController,
                      bgColor: AppColors.lightGrey,
                      hint: AppStrings.enterDesc,
                      borderColor: AppColors.greyColor.withOpacity(0.3),
                    ),
                    SizedBox(height: sizes.height * 0.03,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView.title(
                            text: AppStrings.selectDueDate,
                            textSize: sizes.fontSize17,
                            fontWeight: FontWeight.bold

                        ),
                        SizedBox(width: sizes.width * 0.04,),
                        GestureDetector(
                          onTap: (){
                            selectDate();
                          },
                          child: roundedContainer(
                              borderRadius: sizes.height * 0.008,
                              borderColor: AppColors.pureWhiteColor,
                              backgroundColor: AppColors.normalPriorityColor,
                              widget: Padding(
                                padding:  EdgeInsets.symmetric(
                                  horizontal: sizes.width * 0.03,
                                  vertical: sizes.height * 0.006,
                                ),
                                child: Row(
                                  children: [
                                    iconWidget(
                                        icon: Icons.calendar_month_rounded,
                                        color: AppColors.pureWhiteColor,
                                        size: sizes.height * 0.025
                                    ),
                                    SizedBox(width: sizes.width * 0.03,),
                                    TextView.title(
                                        text: AppStrings.openCalender,
                                        textSize: sizes.fontSize16,
                                        color: AppColors.pureWhiteColor
                                    ),
                                  ],
                                ),
                              )),
                        ),

                      ],
                    ),
                    isDateSelected
                    ? Column(
                      children: [
                      SizedBox(height: sizes.height * 0.02,),
                      Center(
                        child: TextView.title(
                            text: '${AppStrings.youHaveSelected} $formattedDate',
                            textSize: sizes.fontSize16
                        ),
                      ),
                    ],)
                    : Container(),
                    SizedBox(height: sizes.height * 0.03,),
                    TextView.title(
                        text: AppStrings.selectTaskPriority,
                        textSize: sizes.fontSize17,
                        fontWeight: FontWeight.bold
                    ),
                    SizedBox(height: sizes.height * 0.02,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        priorityContainerWidget(
                          bgColor: priorityLevel == AppStrings.normal
                                      ? AppColors.pinkColor
                                      : AppColors.darkGrey,
                            onTap: (){
                              updatePriorityLevel(AppStrings.normal);
                            },
                            title: AppStrings.normal
                        ),
                        priorityContainerWidget(
                            bgColor: priorityLevel == AppStrings.notImportant
                                ? AppColors.pinkColor
                                : AppColors.darkGrey,
                            onTap: (){
                              updatePriorityLevel(AppStrings.notImportant);
                            },
                            title: AppStrings.notImportant),

                      ],
                    ),
                    SizedBox(height: sizes.height * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        priorityContainerWidget(
                            bgColor: priorityLevel == AppStrings.important
                                ? AppColors.pinkColor
                                : AppColors.darkGrey,
                            onTap: (){
                              updatePriorityLevel(AppStrings.important);
                            },
                            title: AppStrings.important),
                        priorityContainerWidget(
                            bgColor: priorityLevel == AppStrings.urgent
                                ? AppColors.pinkColor
                                : AppColors.darkGrey,
                            onTap: (){
                              updatePriorityLevel(AppStrings.urgent);
                            },
                            title: AppStrings.urgent),
                      ],
                    ),
                    SizedBox(height: sizes.height * 0.05,),
                    if (state is AddNewTodoTaskLoadingState)
                      const CircularProgressIndicator(
                      color: AppColors.darkGrey,
                    )
                    else Center(
                      child: Button(
                        onPress: (){
                          context.read<AddNewTodoTaskBloc>().add(
                            AddNewTodoTaskLoadingEvent(
                              context,
                              title: titleController.text,
                              desc: descController.text,
                              selectedDate: formattedDate,
                              taskPriority: priorityLevel,
                            )
                          );
                        },
                        width: sizes.width * 0.9,
                        text: AppStrings.createNewTask,
                        btnColor: AppColors.pinkColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if(state is AddNewTodoTaskLoadingState){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextView.title(
                      text: AppStrings.creatingTask,
                      textSize: sizes.fontSize16,
                  ),
                  SizedBox(height: sizes.height * 0.03,),
                  const CircularProgressIndicator(
                    color: AppColors.pinkColor,
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
