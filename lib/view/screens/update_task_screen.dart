import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:take_home_challenge/config/language_constants.dart';
import 'package:take_home_challenge/models/todo_task_model.dart';
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
import 'package:take_home_challenge/view_model/bloc/update_task/update_task_bloc.dart';
import 'package:take_home_challenge/view_model/bloc/update_task/update_task_events.dart';
import 'package:take_home_challenge/view_model/bloc/update_task/update_task_states.dart';

class UpdateTaskScreen extends StatefulWidget {
  final ToDoTaskModel? toDoTaskModel;

  const UpdateTaskScreen({this.toDoTaskModel, super.key});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  String priorityLevel = '';
  String formattedDate = '';
  bool isDateSelected = false;
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    titleController  = TextEditingController(text: widget.toDoTaskModel!.content);
    descController  = TextEditingController(text: widget.toDoTaskModel!.description);
    priorityLevel = getPriorityLevel(widget.toDoTaskModel!.priority!);
    formattedDate = widget.toDoTaskModel!.due?.date ?? '';
    if(formattedDate != '' ){
      isDateSelected = true;
    }
    super.initState();
  }

  String getPriorityLevel(int priority){
    String priorityLevel = AppStrings.normal;
    switch(priority){
      case 1:
        priorityLevel = AppStrings.normal;
        break;
      case 2:
        priorityLevel = AppStrings.notImportant;
        break;
      case 3:
        priorityLevel = AppStrings.important;
        break;
      case 4:
        priorityLevel = AppStrings.urgent;
        break;
    }
    return priorityLevel;
  }

  @override
  Widget build(BuildContext context) {
    context.read<UpdateTaskBloc>().add(InitialEvent());
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
      body: BlocConsumer<UpdateTaskBloc, UpdateTaskStates>(
        listener: (BuildContext context, UpdateTaskStates state) {
          if(state is UpdateTaskSuccessState){
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
                            text: translation(context).updateTask,
                            textSize: sizes.fontSize18,
                            font: Fonts.poppinsSemiBold
                        )
                      ],
                    ),
                    SizedBox(height: sizes.height * 0.04,),
                    TextFieldWidget(
                      textEditingController: titleController,
                      bgColor: AppColors.lightGrey,
                      hint: translation(context).enterTitle,
                      borderColor: AppColors.greyColor.withOpacity(0.3),
                    ),
                    SizedBox(height: sizes.height * 0.02,),
                    TextFieldWidget(
                      textEditingController: descController,
                      bgColor: AppColors.lightGrey,
                      hint: translation(context).enterDesc,
                      borderColor: AppColors.greyColor.withOpacity(0.3),
                    ),
                    SizedBox(height: sizes.height * 0.03,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: sizes.width * 0.4,
                          child: TextView.title(
                              textAlign: TextAlign.start,
                              text: translation(context).selectDueDate,
                              textSize: sizes.fontSize17,
                              fontWeight: FontWeight.bold

                          ),
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
                                    SizedBox(
                                      width: sizes.width * 0.3,
                                      child: TextView.title(
                                          isOverFlow: true,
                                          text: translation(context).openCalender,
                                          textSize: sizes.fontSize16,
                                          color: AppColors.pureWhiteColor
                                      ),
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
                            text: '${translation(context).youHaveSelected} $formattedDate',
                            textSize: sizes.fontSize16
                        ),
                      ),
                    ],)
                    : Container(),
                    SizedBox(height: sizes.height * 0.03,),
                    TextView.title(
                        text: translation(context).selectTaskPriority,
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
                            title: translation(context).normal
                        ),
                        priorityContainerWidget(
                            bgColor: priorityLevel == AppStrings.notImportant
                                ? AppColors.pinkColor
                                : AppColors.darkGrey,
                            onTap: (){
                              updatePriorityLevel(AppStrings.notImportant);
                            },
                            title: translation(context).notImportant),

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
                            title: translation(context).important),
                        priorityContainerWidget(
                            bgColor: priorityLevel == AppStrings.urgent
                                ? AppColors.pinkColor
                                : AppColors.darkGrey,
                            onTap: (){
                              updatePriorityLevel(AppStrings.urgent);
                            },
                            title: translation(context).urgent),
                      ],
                    ),
                    SizedBox(height: sizes.height * 0.05,),
                    if (state is UpdateTaskLoadingState)
                      const CircularProgressIndicator(
                      color: AppColors.darkGrey,
                    )
                    else Center(
                      child: Button(

                        onPress: (){
                          context.read<UpdateTaskBloc>().add(
                            UpdateTaskLoadingEvent(
                              context,
                              id: widget.toDoTaskModel!.id!,
                              title: titleController.text,
                              desc: descController.text,
                              selectedDate: formattedDate,
                              taskPriority: priorityLevel,
                            )
                          );
                        },
                        width: sizes.width * 0.9,
                        text: translation(context).updateTask,
                        btnColor: AppColors.pinkColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if(state is UpdateTaskLoadingState){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextView.title(
                      text: translation(context).updatingTask,
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
