import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, Color color, FontWeight fontWeight, double? height) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: height,
      fontFamily: FontConstants.arFontFamily);
}

TextStyle getLightStyle(
    {double fontSize = 12, required Color color, double? height}) {
  return _getTextStyle(fontSize, color, FontWeightManager.light, height);
}

TextStyle getRegularStyle(
    {double fontSize = 12, required Color color, double? height}) {
  return _getTextStyle(fontSize, color, FontWeightManager.regular, height);
}

TextStyle getMediumStyle(
    {double fontSize = 12, required Color color, double? height}) {
  return _getTextStyle(fontSize, color, FontWeightManager.medium, height);
}

TextStyle getSemiBoldStyle(
    {double fontSize = 12, required Color color, double? height}) {
  return _getTextStyle(fontSize, color, FontWeightManager.semiBold, height);
}

TextStyle getBoldStyle({
  double fontSize = 12,
  required Color color,
  double? height,
}) {
  return _getTextStyle(fontSize, color, FontWeightManager.bold, height);
}

TextStyle getBlackStyle({
  double fontSize = 12,
  required Color color,
  double? height,
}) {
  return _getTextStyle(fontSize, color, FontWeightManager.maxBold, height);
}
