import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';

showLoaderDialog(BuildContext context, {String? title}){
  AlertDialog alert=AlertDialog(
    content: SizedBox(
      height: sizes.height * 0.1,
      child: Row(
        children: [
          const CircularProgressIndicator(
            color: AppColors.pinkColor,
          ),
          Container(
              margin: EdgeInsets.only(left: sizes.width * 0.1),
              child: TextView.title(
                  text: title ?? 'Loading your data',
                  textSize: sizes.fontSize16
              )
          ),
        ],),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}