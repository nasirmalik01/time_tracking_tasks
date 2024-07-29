import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';

Widget iconWidget({
  required IconData icon,
  Color? color,
  double? size,
  Function()? onTap
}){
  return GestureDetector(
    onTap: onTap,
    child: Icon(
      icon,
      color: color ?? AppColors.blackColor,
      size: size ?? sizes.height * 0.03,

  ));
}