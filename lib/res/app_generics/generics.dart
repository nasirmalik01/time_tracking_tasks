import 'package:flutter/cupertino.dart';
import 'package:take_home_challenge/res/app_generics/sizes.dart';

AppSizes sizes = AppSizes();

bool _isInitialized = false;

void initializeResources({required BuildContext context}) {
  AppSizes().initializeSize(context);
  if (_isInitialized) {
    /**
     * this is to prevent
     * multiple initialization calls.
     */
    return;
  }

  sizes = AppSizes()..initializeSize(context);
}

BuildContext? currentContext;

void setCurrentContext(BuildContext context) {
  currentContext = context;
}

double getWidthRatio() => sizes.widthRatio;
double getHeightRatio() => sizes.heightRatio;
double getFontRatio() => sizes.fontRatio;
double getHeight() => sizes.height;
double getWidth() => sizes.width;

double commonWidth=getWidth()*.9;
