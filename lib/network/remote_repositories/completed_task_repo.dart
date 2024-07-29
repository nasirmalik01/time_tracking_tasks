import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/strings.dart';

class InProgressAndCompletedTasksRepo {
  static Future<List> getTasks({String? docId}) async {
    List completedTaskModelList = [];
    await FirebaseFirestore.instance.collection(docId ?? AppStrings.completed)
        .get().then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                Map completedTasksData = doc.data() as Map;
                completedTasksData['color'] = getPriorityColor(completedTasksData['priority']);
                completedTaskModelList.add(completedTasksData);
              })
            });
    return completedTaskModelList;
  }

 static Color getPriorityColor(String priority){
    Color color = AppColors.normalPriorityColor;
    switch(priority){
      case AppStrings.normal:
        color = AppColors.normalPriorityColor;
        break;
      case AppStrings.notImportant:
        color = AppColors.notImportantPriorityColor;
        break;
      case AppStrings.important:
        color = AppColors.importantPriorityColor;
        break;
      case AppStrings.urgent:
        color = AppColors.urgentPriorityColor;
        break;
    }
    return color;
  }
}

