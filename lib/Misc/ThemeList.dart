import 'Themes.dart';
import 'package:flutter/material.dart';
import 'package:enum_to_string/enum_to_string.dart';


class ThemeOptions{
  Color themeColor;
  ThemeType enumTheme;

  ThemeOptions({this.themeColor, this.enumTheme});

  ThemeOptions.fromJson(Map<String, dynamic> json)
      : themeColor = Color(json['themeColor']),
        enumTheme = json['enumTheme'];

  Map<String, dynamic> toJson()=>{
    'themeColor' : themeColor.toString(),
    'enumType' :  EnumToString.parse(enumTheme),
  };
}
List<ThemeOptions> themes = [
  ThemeOptions(themeColor: Colors.teal, enumTheme: ThemeType.Teal),
  ThemeOptions(themeColor: Colors.green, enumTheme: ThemeType.Green),
  ThemeOptions(themeColor: Colors.lightGreen, enumTheme: ThemeType.LightGreen),

  ThemeOptions(themeColor: Colors.lightGreenAccent, enumTheme: ThemeType.LightGreenAccent),
  ThemeOptions(themeColor: Colors.lime, enumTheme: ThemeType.Lime),
  ThemeOptions(themeColor: Colors.blue, enumTheme: ThemeType.Blue),

  ThemeOptions(themeColor: Colors.lightBlueAccent, enumTheme: ThemeType.LightBlueAccent),
  ThemeOptions(themeColor: Colors.yellow, enumTheme: ThemeType.Yellow),
  ThemeOptions(themeColor: Colors.orange, enumTheme: ThemeType.Orange),

  ThemeOptions(themeColor: Colors.deepOrange, enumTheme: ThemeType.DeepOrange),
  ThemeOptions(themeColor: Colors.red, enumTheme: ThemeType.Red),
  ThemeOptions(themeColor: Colors.pink, enumTheme: ThemeType.Pink),

  ThemeOptions(themeColor: Colors.purple, enumTheme: ThemeType.Purple),
  ThemeOptions(themeColor: Colors.deepPurple, enumTheme: ThemeType.DeepPurple),
  ThemeOptions(themeColor: Colors.brown, enumTheme: ThemeType.Brown),

  ThemeOptions(themeColor: Colors.white30, enumTheme: ThemeType.White30),
  ThemeOptions(themeColor: Colors.black45, enumTheme: ThemeType.Black45),
];


class FolderColorOptions{
  Color color;
  int objectId;
  FolderColorOptions(this.color, this.objectId);
}

List<FolderColorOptions> folderColor = [
  FolderColorOptions(Colors.teal.shade300, 0),
  FolderColorOptions(Colors.green.shade300, 1),
  FolderColorOptions(Colors.lightGreen.shade300, 2),
  FolderColorOptions(Colors.lime.shade300, 3),
  FolderColorOptions(Colors.blue.shade300, 4),
  FolderColorOptions(Colors.lightBlue.shade300, 5),
  FolderColorOptions(Colors.yellow.shade300, 6),
  FolderColorOptions(Colors.orange.shade300, 7),
  FolderColorOptions(Colors.orangeAccent, 8),
  FolderColorOptions(Colors.deepOrange.shade300, 9),
  FolderColorOptions(Colors.red.shade300, 10),
  FolderColorOptions(Colors.pink.shade300, 11),
  FolderColorOptions(Colors.purple.shade300, 12),
  FolderColorOptions(Colors.brown.shade300, 13),
];