import 'package:flutter/material.dart';
import 'package:take_home_challenge/config/language_constants.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/fonts.dart';
import 'package:take_home_challenge/res/strings.dart';
import 'package:take_home_challenge/view/widgets/textviews.dart';

class CommentsWidget extends StatelessWidget {
  final Widget widget;

  const CommentsWidget({
    required this.widget,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizes.height,
      width: sizes.width,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: sizes.width * 0.04
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: sizes.height * 0.04,),
            TextView.title(
                text: translation(context).comments,
                textSize: sizes.fontSize22,
                font: Fonts.poppinsRegular,
                fontWeight: FontWeight.w500
            ),
            SizedBox(height: sizes.height * 0.03,),
            Expanded(
              child: widget,
            )
          ],
        ),
      ),
    );
  }
}
