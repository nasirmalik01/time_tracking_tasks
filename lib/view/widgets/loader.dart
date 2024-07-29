import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';

Widget loadingDataWidget({String? title}){
  return Padding(
    padding: EdgeInsets.only(bottom: sizes.height * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: AppColors.pinkColor,
        ),
        Container(
            margin: EdgeInsets.only(left: sizes.width * 0.1),
            child: TextView.title(
                text: title ?? 'Loading your task data',
                textSize: sizes.fontSize16
            )
        ),
      ],),
  );
}