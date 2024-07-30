import 'package:flutter/cupertino.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';

Widget priorityContainerWidget({required String title, Function()? onTap, Color? bgColor}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
        width: sizes.width * 0.42,
        height: sizes.height * 0.05,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.darkGrey,
          border: Border.all(
              color: AppColors.pureWhiteColor),
          borderRadius: BorderRadius.circular(sizes.height * 0.007),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: sizes.width * 0.03,
            vertical: sizes.height * 0.004,
          ),
          child: Center(
            child: TextView.title(
                text: title,
                textSize: sizes.fontSize16,
                color: AppColors.pureWhiteColor
            ),
          ),
        )),
  );
}