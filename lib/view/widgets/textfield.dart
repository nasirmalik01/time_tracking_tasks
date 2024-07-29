import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController ? textEditingController;
  final bool ? obscureText;
  final String?  hint;
  final TextInputType? textInputType;
  final double ? width;
  final String ? icon;
  final Color? borderColor;
  final Color? bgColor;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? cursorColor;


  const TextFieldWidget(
      {Key? key, this.textEditingController,
        this.obscureText,
        this.hint,
        this.textInputType,
        this.width,
        this.icon,
        this.borderColor,
        this.bgColor,
        this.textColor,
        this.hintTextColor,
        this.cursorColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight() * 0.07,
      width:  width??sizes.width,
      decoration: BoxDecoration(
          color: bgColor?? AppColors.lightGrey,
          border: Border.all(color: borderColor?? AppColors.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(getHeight()*.01))
      ),
      child: Center(
        child: TextField(

          controller: textEditingController,
          obscureText:obscureText?? false,
          cursorHeight: getHeight()*.03,
          keyboardType: textInputType??TextInputType.text,
          cursorColor: cursorColor?? AppColors.lightBlack,
          style: TextStyle(
            color: textColor ?? AppColors.lightBlack,
            fontSize: sizes.fontSize15,
            fontFamily: Fonts.poppinsMedium,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: getWidth()*.02),
              hintText: hint??"",
              alignLabelWithHint: false,
              hintStyle: TextStyle(
                color: hintTextColor ?? AppColors.darkGrey,
                fontSize: sizes.fontSize15,
                fontFamily:Fonts.poppinsMedium,
              )
          ),
        ),
      ),
    );
  }
}
