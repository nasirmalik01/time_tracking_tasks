import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/view/widgets/icon_widget.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';

import '../../res/app_generics/generics.dart';
import 'rounded_container.dart';

Widget taskIconWidget({
  Color? color,
  IconData? icon,
  bool isFinish = false,
  Function()? onTap
}){
  return GestureDetector(
    onTap: onTap,
    child: roundedContainer(
        borderRadius: sizes.height * 0.01,
        borderColor: AppColors.pureWhiteColor,
        backgroundColor: color,
        widget: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: sizes.width * 0.02,
              vertical: sizes.height * 0.006,
            ),
            child: isFinish
            ?  TextView.title(
                text: AppStrings.finish,
                textSize: sizes.fontSize16,
                color: AppColors.pureWhiteColor
            ) :iconWidget(
                icon: icon!,
                color: AppColors.pureWhiteColor,
                size: sizes.height * 0.02
            )

        )),
  );
}