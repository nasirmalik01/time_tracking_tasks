import 'package:flutter/material.dart';
import 'package:take_home_challenge/config/language_constants.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/res/strings.dart';

FloatingActionButton extendedFAB(BuildContext context, {String? title, Function()? onPress}){
  return FloatingActionButton.extended(
    shape: const StadiumBorder(),
    backgroundColor: AppColors.pinkColor,
    onPressed: onPress,
    label: Text(
       title ?? translation(context).addNewTask,
      style:
      TextStyle(
        fontSize: sizes.fontSize16,
        color:AppColors.pureWhiteColor,
        fontFamily: Fonts.poppinsRegular,
        fontWeight: FontWeight.w500,
      ),),
    icon: const Icon(Icons.add, color: Colors.white, size: 25),
  );
}