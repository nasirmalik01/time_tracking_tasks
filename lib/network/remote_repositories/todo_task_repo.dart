import 'dart:ui';

import 'package:take_home_challenge/models/todo_task_model.dart';
import 'package:take_home_challenge/network/remote_services.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/utils/methods/methods.dart';

class TodoTaskRepo{
  /// Getting todo list
  static Future<List<ToDoTaskModel>?> getTodoTasksList() async {
    List<ToDoTaskModel> toDoTaskList = [];
    final response = await getItLocator<RemoteServices>()
        .getRequest('', {});
    if (response == null) {
      return null;
    }
    final List<dynamic> toDoTaskDecodeList =
    response.map((item) => ToDoTaskModel.fromJson(item)).toList();
    for (ToDoTaskModel toDoTaskItem in toDoTaskDecodeList) {
      toDoTaskItem.priorityLevel = getPriorityLevel(toDoTaskItem.priority!);
      toDoTaskItem.priorityColor = getPriorityColor(toDoTaskItem.priority!);
        toDoTaskList.add(toDoTaskItem);
    }
    return toDoTaskList;
  }

  /// Delete todo task
  static Future<void> deleteTodoTask({required String id}) async {
    final response = await getItLocator<RemoteServices>()
        .deleteRequest('/$id', {});

    print('Delete Request response: $response');
  }


  /// Complete todo task
  static Future<void> finishTodoTask({
    required String id,
    Map<String, dynamic>? query
  }) async {
    final response = await getItLocator<RemoteServices>()
        .postRequest('/$id/${AppStrings.close}', query ?? {});

    print('Complete Request response: $response');
  }


  static String getPriorityLevel(int priority){
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

 static Color getPriorityColor(int priority){
    Color priorityColor = AppColors.normalPriorityColor;
    switch(priority){
      case 1:
        priorityColor = AppColors.normalPriorityColor;
        break;
      case 2:
        priorityColor = AppColors.notImportantPriorityColor;
        break;
      case 3:
        priorityColor = AppColors.importantPriorityColor;
        break;
      case 4:
        priorityColor = AppColors.urgentPriorityColor;
        break;
    }
    return priorityColor;
  }
}