import 'package:flutter/material.dart';
import 'package:take_home_challenge/config/language_constants.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/view/widgets/tab_widget.dart';

PreferredSizeWidget appBarWidget(BuildContext context, {required List<Widget> widget}){
  return AppBar(
    centerTitle: false,
    title: Text(translation(context).appBarText),
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
              tabWidget(title: translation(context).toDo),
              tabWidget(title: translation(context).inProgress),
              tabWidget(title: translation(context).completed),

            ],
          ),
        ),
      ),
    ),
    actions: widget
  );
}
