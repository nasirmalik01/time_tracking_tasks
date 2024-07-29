import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/view/widgets/icon_widget.dart';
import 'package:take_home_challenge/view/widgets/rounded_container.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';

Widget commentWidget({required String comment}){
  return Container(
    width: sizes.width,
    margin: EdgeInsets.only(
        bottom: sizes.height * 0.02
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: sizes.height * 0.02,
            backgroundColor: AppColors.greyColor.withOpacity(0.5),
            child: iconWidget(
              icon: Icons.account_circle_outlined,
              size: sizes.height * 0.03,
              color: AppColors.pureWhiteColor,

            )
        ),
        SizedBox(width: sizes.width * 0.03,),
        Expanded(
          child: roundedContainer(
              widget: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizes.width * 0.02,
                    vertical: sizes.height * 0.015
                ),
                child: TextView.title(
                    textAlign: TextAlign.start,
                    text: comment,
                    textSize: sizes.fontSize16
                ),
              )
          ),
        ),
      ],
    ),
  );
}