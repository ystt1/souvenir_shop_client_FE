import 'package:flutter/material.dart';
import 'package:souvenir_shop/common/app_colors.dart';

ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
    ),





    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, // Hoặc màu bạn muốn cho nền button
        foregroundColor: Colors.white, // Màu cho text trên button
        minimumSize: Size(double.infinity, 50), // Kích thước tối thiểu của button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bo góc cho button
        ),
      ),
    ),


    //input theme
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondBackground,)),
        fillColor: AppColors.secondBackground,
        filled: true),




  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    iconTheme: IconThemeData(
      color: AppColors.textColor,

    )
  )
);



