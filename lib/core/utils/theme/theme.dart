
import 'package:flutter/material.dart';

import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/check_box_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class RAppTheme {
  RAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: RTextTheme.lightTextTheme,
    elevatedButtonTheme: RElevatedButtonTheme.lightElevatedButtonTheme,
    chipTheme: RChipTheme.lightChipTheme,
    appBarTheme: RAppBarTheme.lightApPBarTheme,
    checkboxTheme: RCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: RBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: RTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: RTextTheme.darkTextTheme,
    elevatedButtonTheme: RElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: RAppBarTheme.darkAppBarTheme,
    checkboxTheme: RCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: RBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: RTextFormFieldTheme.darkInputDecorationTheme,
  );
}
