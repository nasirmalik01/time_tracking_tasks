import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';


class TextView{
  static Text title({
    required String text,
    Color? color,
    String? font,
    FontWeight? fontWeight,
    required double textSize,
    TextAlign? textAlign,
    bool isOverFlow = false
  }){
    return Text(text,
      textAlign: textAlign ?? TextAlign.center,
      style:
      TextStyle(
        overflow: isOverFlow
          ? TextOverflow.ellipsis
          : TextOverflow.visible,
        fontSize: textSize,
        color: color ?? AppColors.blackColor,
        fontFamily: font ?? Fonts.poppinsRegular,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),);
  }
}