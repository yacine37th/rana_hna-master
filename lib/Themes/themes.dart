import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';

class Themes extends GetxController {
  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 50)),
    textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
    alignment: Alignment.center,
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    foregroundColor: MaterialStateProperty.all<Color>(whiteColor),
    backgroundColor: MaterialStateProperty.all<Color>(tealColor),
    overlayColor: MaterialStateColor.resolveWith(
        (states) => transparentColor.withOpacity(0.2)),
  ));

  static ThemeData customLightTheme = ThemeData.light().copyWith(
      primaryColorDark: whiteColor,
      primaryColorLight: darkBlueColor,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: blackColor, fontSize: 16),
        bodyLarge: TextStyle(color: blackColor),
        bodyMedium: TextStyle(color: blackColor, fontSize: 22),
        titleSmall: TextStyle(color: blackColor, fontSize: 20),
        titleLarge: TextStyle(color: blackColor, fontSize: 22),
        titleMedium: TextStyle(color: blackColor, fontSize: 19),
      ).apply(
        fontFamily: 'Raleway',
      ),
      scaffoldBackgroundColor: whiteColor,
      colorScheme: const ColorScheme.light()
          .copyWith(primary: tealColor, secondary: tealColor),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: transparentColor,
          centerTitle: true,
          surfaceTintColor: darkBlueColor,
          foregroundColor: darkBlueColor),
      primaryColor: tealColor,
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: tealColor),
      inputDecorationTheme: const InputDecorationTheme(
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: transparentColor)),
        fillColor: lightBlueColor,
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: redColor)),
        errorStyle: TextStyle(color: redColor, fontSize: 15),
        errorMaxLines: 3,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: redColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: transparentColor, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: tealColor, width: 2)),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        hintStyle: TextStyle(fontSize: 19),
      ),
      textButtonTheme: textButtonThemeData,
      cardTheme: CardTheme(
          elevation: 5,
          color: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      listTileTheme: const ListTileThemeData(
        visualDensity: VisualDensity(vertical: -4),
        textColor: blackColor,
        contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 20),
        tileColor: lightBlueColor,
      ));
}
