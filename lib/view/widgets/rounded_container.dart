import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/colors.dart';

Widget roundedContainer({
  required Widget widget,
  double? width,
  double? height,
  Color? borderColor,
  double? borderRadius,
  Color? backgroundColor
}) {
  return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        border: Border.all(
            color: borderColor ?? AppColors.greyColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      child: widget);
}
