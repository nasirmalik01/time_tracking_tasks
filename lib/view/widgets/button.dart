import 'package:flutter/material.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';

class Button extends StatelessWidget {
  final double ? width;
  final double ? height;
  final String ? text;
  final Function ? onPress;
  final Color ? btnColor;
  final Color ? textColor;
  final Color ? borderColor;
  final double? textSize;


  const Button(
      {Key? key, this.width,
        this.height,
        this.text,
        this.onPress,
        this.btnColor,
        this.textColor,
        this.borderColor,
        this.textSize
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //key: const Key('Main button'),
      onTap: (){
        onPress!.call();
      },
      child: Container(
        height: height?? getHeight() * 0.075,
        width:  width?? getWidth(),
        decoration: BoxDecoration(
          color: btnColor??AppColors.greyColor,
          border: Border.all(color: borderColor??Colors.transparent),
          borderRadius: BorderRadius.circular(getWidth()*.02,),
        ),
        child:  Center(
            child: TextView.title(
                text: text??"SUBMIT",
                textSize: textSize ?? sizes.fontSize16,
                font: Fonts.poppinsMedium,
                color: textColor ?? AppColors.pureWhiteColor
            )
        ),

      ),
    );
  }
}
