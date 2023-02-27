import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey1,
    scaffoldBackgroundColor: ColorManager.white,
    iconTheme: IconThemeData(color: ColorManager.fontColor, size: 20.h),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    dividerColor: Colors.transparent,
    unselectedWidgetColor: ColorManager.grey4,

    // App bar theme
    appBarTheme: AppBarTheme(
        color: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.accent),
        elevation: 0,
        centerTitle: true),
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey1,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorManager.scaffoldDarkColor,
    iconTheme: IconThemeData(color: ColorManager.white, size: 20.h),
    visualDensity: VisualDensity.adaptivePlatformDensity,

    // App bar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.scaffoldDarkColor,
      iconTheme: IconThemeData(color: ColorManager.white),
      elevation: 0,
      centerTitle: true,
    ),
  );
}
