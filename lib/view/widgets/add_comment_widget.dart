import 'package:flutter/material.dart';
import 'package:take_home_challenge/config/language_constants.dart';
import 'package:take_home_challenge/res/app_generics/generics.dart';
import 'package:take_home_challenge/res/colors.dart';
import 'package:take_home_challenge/res/strings.dart';

class AddCommentWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onPress;

  const AddCommentWidget({this.controller, this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                bottom: sizes.height*0.03,
                right: sizes.width*0.04,
                left: sizes.width*0.05,
              ),
              padding:  EdgeInsets.symmetric(
                horizontal: sizes.width * 0.04,
                vertical: sizes.height*0.006,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: controller,
                decoration: InputDecoration(
                    hintText: translation(context).addCommentHint,
                    border: InputBorder.none),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                bottom: sizes.height*0.03,
                right: sizes.width*0.04,
              ),
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: AppColors.pinkColor,
                onPressed: onPress,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
          ),
        ]);
  }
}
