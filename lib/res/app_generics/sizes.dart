import 'package:flutter/material.dart';

class AppSizes {
  late Size _screenSize;
  late bool isPhone;
  late double width;
  late double height;
  late double topPadding;

  //For dynamic Sizing
  late double widthRatio;
  late double heightRatio;
  late double fontRatio;

  //Dynamic Font Sizes
  late double fontSize10;
  late double fontSize11;
  late double fontSize12;
  late double fontSize13;
  late double fontSize14;
  late double fontSize15;
  late double fontSize16;
  late double fontSize17;
  late double fontSize18;
  late double fontSize20;

  late double fontSize22;
  late double fontSize25;
  late double fontSize27;
  late double fontSize30;
  late double fontSize35;

  //padding
  late double smallPadding;
  late double regularPadding;
  late double mediumPadding;
  late double pagePadding;
  late double largePadding;
  late double extraLargePadding;
  late double extraLargePaddingSafeArea;
  late double largerPadding;

  //tablet specific padding
  late double tabletInnerPadding;
  late double tabletOuterPadding;
  late double tabletPagePadding;
  late double tabletLargeOuterMargin;
  late double tabletExtraLargeOuterMargin;
  late double tabletSocialMediaPadding;
  late double tabletAuthCommentPadding;

  void initializeSize(context) {
    _screenSize = MediaQuery.of(context).size;
    topPadding = MediaQuery.of(context).padding.top;
    width = _screenSize.shortestSide;
    height = _screenSize.longestSide;
    isPhone = _screenSize.shortestSide < 600;
    fontRatio = (isPhone && _screenSize.width <= 360) ? _screenSize.width / 360 : 1.0;
    widthRatio = isPhone ? _screenSize.width / 360 : _screenSize.width / 900;
    heightRatio = isPhone ? _screenSize.height / 720 : _screenSize.height / 1200;

    fontSize10 = 10.0 * fontRatio;

    fontSize11 = 11.0 * fontRatio;
    fontSize12 = 12.0 * fontRatio;
    fontSize13 = 13.0 * fontRatio;
    fontSize14 = 14.0 * fontRatio;
    fontSize15 = 15.0 * fontRatio;
    fontSize16 = 16.0 * fontRatio;
    fontSize17 = 17.0 * fontRatio;
    fontSize18 = 18.0 * fontRatio;
    fontSize20 = 20.0 * fontRatio;

    fontSize22 = 22.0 * fontRatio;
    fontSize25 = 25.0 * fontRatio;
    fontSize27 = 27.0 * fontRatio;
    fontSize30 = 30.0 * fontRatio;
    fontSize35 = 35.0 * fontRatio;

    smallPadding = 4.0 * widthRatio;
    regularPadding = 8.0 * widthRatio;
    mediumPadding = 12.0 * widthRatio;
    pagePadding = 20.0 * widthRatio;
    largePadding = 24.0 * widthRatio;
    extraLargePadding = 32.0 * widthRatio;
    extraLargePaddingSafeArea = 52.0 * widthRatio;
    largerPadding = 32.0 * widthRatio;

    tabletOuterPadding = 144.0 * widthRatio;
    tabletInnerPadding = 76.0 * widthRatio;
    tabletPagePadding = 48.0 * widthRatio;
    tabletExtraLargeOuterMargin = 228.0 * widthRatio;
    tabletLargeOuterMargin = 172.0 * widthRatio;
    tabletSocialMediaPadding = 192.0 * widthRatio;
    tabletAuthCommentPadding = 99.0 * widthRatio;
  }

  void refreshSize(context) {
    _screenSize = MediaQuery.of(context).size;
    width = _screenSize.width;
    height = _screenSize.height;
  }
}