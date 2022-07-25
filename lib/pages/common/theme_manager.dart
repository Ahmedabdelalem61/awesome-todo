import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme = ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: TextStyle(color: Colors.black)
        ),
        tabBarTheme: const TabBarTheme(
           unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
           labelStyle: TextStyle(fontSize: 13)
        ),
        backgroundColor: Colors.white,
      );