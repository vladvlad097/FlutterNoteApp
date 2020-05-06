import 'package:shared_preferences/shared_preferences.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutternoteapp/Misc/Themes.dart';

//class ThemeOptions{
//  Color themeColor;
//  ThemeType enumTheme;
//
//  ThemeOptions({this.themeColor, this.enumTheme});
//
//  ThemeOptions.fromJson(Map<String, dynamic> json)
//      : themeColor = Color(json['themeColor']),
//        enumTheme = json['enumTheme'];
//
//  Map<String, dynamic> toJson()=>{
//    'themeColor' : themeColor.toString(),
//    'enumType' :  EnumToString.parse(enumTheme),
//  };
//}
//
//class SharedPref{
//  saveThemeToSharedPref(String key, ThemeOptions value) async{
//    final prefs = await SharedPreferences.getInstance();
//    prefs.setString(key, json.encode(value.toJson()));
//    print('dataSaved');
//    print(prefs.getString(key));
//  }
//
//  readThemeFromSharedPref(String key) async{
//    final prefs = await SharedPreferences.getInstance();
//    print('dataloaded');
//    return json.decode((prefs.getString(key)));
//  }
//}