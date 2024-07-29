import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/view/widgets/tab_widget.dart';

PreferredSizeWidget appBarWidget(){
  return AppBar(
    title: const Text(AppStrings.appBarText),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        height: sizes.height * 0.07,
        padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: sizes.height * 0.01,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: AppColors.transparentColor,
          ),
          child: TabBar(
            labelColor: AppColors.pureWhiteColor,
            unselectedLabelColor: AppColors.blackColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              color: AppColors.pinkColor,
            ),
            tabs: [
              tabWidget(title: AppStrings.toDo),
              tabWidget(title: AppStrings.inProgress),
              tabWidget(title: AppStrings.completed),

            ],
          ),
        ),
      ),
    ),
  );
}
