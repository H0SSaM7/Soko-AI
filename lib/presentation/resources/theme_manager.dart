import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    fontFamily: FontConstants.arFontFamily,
    dialogBackgroundColor: Colors.white,
    dividerColor: ColorManager.lightGray,
    colorScheme: const ColorScheme.light(
      primary: ColorManager.primary,
      surface: ColorManager.background,
      surfaceTint: Colors.transparent,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.s10)),
    ),
    appBarTheme: _appBarTheme(),
    elevatedButtonTheme: _elevatedButtonTheme(),
    outlinedButtonTheme: _outlineButtonTheme(),
    textTheme: _textTheme(),
    inputDecorationTheme: _inputDecorationTheme(),
    dividerTheme:
        DividerThemeData(color: ColorManager.lightGray, thickness: 1.h),
    switchTheme: const SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(
        ColorManager.white,
      ),
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: const WidgetStatePropertyAll(ColorManager.white),
      checkColor: const WidgetStatePropertyAll(ColorManager.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.s2),
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(width: AppSize.s1, color: ColorManager.white),
      ),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    hintStyle: getLightStyle(
      color: ColorManager.lightGray,
      fontSize: FontSize.s16,
    ),
    labelStyle: getLightStyle(
      color: ColorManager.lightGray,
      fontSize: FontSize.s14,
    ),
    contentPadding:
        EdgeInsets.fromLTRB(0.0, AppHeight.s12, AppWidth.s16, AppHeight.s12),
    fillColor: Colors.transparent,
    isDense: true,
    filled: true,
    constraints: BoxConstraints(minHeight: AppHeight.s46),
    focusedBorder: getOutlineInputBorder(color: ColorManager.primary),
    disabledBorder: getOutlineInputBorder(),
    enabledBorder: getOutlineInputBorder(),
    errorBorder: getOutlineInputBorder(),
    focusedErrorBorder: getOutlineInputBorder(),
  );
}

OutlineInputBorder getOutlineInputBorder(
    {Color? color, double? width, double? radius}) {
  return OutlineInputBorder(
      borderSide: BorderSide(
          color: color ?? ColorManager.lightGray, width: width ?? 1.r),
      borderRadius: BorderRadius.circular(radius ?? AppRadius.s10));
}

BoxShadow getPrimayBoxShadow() {
  return BoxShadow(
    color: ColorManager.black.withOpacity(
      0.07,
    ),
    blurRadius: AppRadius.s10,
    spreadRadius: AppRadius.s1,
    offset: const Offset(0, 0),
  );
}

SystemUiOverlayStyle getBlueUiOverlayStyle() {
  return const SystemUiOverlayStyle(
      statusBarColor: ColorManager.primary,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
}

TextTheme _textTheme() {
  return TextTheme(
    headlineLarge: getBoldStyle(
      color: ColorManager.white,
      fontSize: FontSize.s24,
    ),
    headlineMedium: getSemiBoldStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s20,
    ),
    headlineSmall: getMediumStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s20,
    ),
    titleLarge: getBoldStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s20,
    ),
    titleMedium: getMediumStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s18,
    ),
    titleSmall: getRegularStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s18,
    ),
    labelLarge: getMediumStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s16,
    ),
    labelMedium: getRegularStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s16,
    ),
    labelSmall: getLightStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s16,
    ),
    bodyLarge: getBoldStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s15,
    ),
    bodyMedium: getRegularStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s14,
    ),
    bodySmall: getLightStyle(
      color: ColorManager.darkPrimary,
      fontSize: FontSize.s14,
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
      backgroundColor: ColorManager.primary,
      foregroundColor: ColorManager.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.s10),
      ),
    ),
  );
}

OutlinedButtonThemeData _outlineButtonTheme() {
  return OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
      backgroundColor: Colors.transparent,
      foregroundColor: ColorManager.primary,
      elevation: 0,
      side: BorderSide(color: ColorManager.primary, width: 1.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.s10),
      ),
    ),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    titleTextStyle:
        getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark),
    iconTheme: const IconThemeData(color: ColorManager.darkPrimary),
    color: Colors.transparent,
    centerTitle: true,
    elevation: 0.0,
  );
}
