import 'package:flutter/material.dart';

Widget tabWidget({required String title}){
  return ConstrainedBox(
    constraints: const BoxConstraints.expand(),
    child: Tab(
      text: title,
    ),
  );
}