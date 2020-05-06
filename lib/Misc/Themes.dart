import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum ThemeType {Teal, Green, LightGreen, LightGreenAccent, Lime, Blue, LightBlueAccent, Yellow, Orange, DeepOrange, Red, Pink, Purple, DeepPurple, Brown, White30, Black45}

//TODO: How will it look if i just change the color swatch for each theme insead of having shades of that color

ThemeData tealTheme = ThemeData.light().copyWith(

  primaryColor: Colors.teal.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.teal.shade700,
  ),

);

ThemeData greenTheme = ThemeData.light().copyWith(

  primaryColor: Colors.green.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.green.shade700,
  ),

);

ThemeData lightGreenTheme = ThemeData.light().copyWith(

  primaryColor: Colors.lightGreen.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.lightGreen.shade700,
  ),

);

ThemeData lightGreenAccentTheme = ThemeData.light().copyWith(

  primaryColor: Colors.lightGreenAccent.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.lightGreenAccent.shade700,
  ),

);

ThemeData limeTheme = ThemeData.light().copyWith(

  primaryColor: Colors.lime.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.lime.shade700,
  ),

);

ThemeData blueTheme = ThemeData.light().copyWith(

  primaryColor: Colors.blue.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.blue.shade700,
  ),

);

ThemeData lightBlueAccentTheme = ThemeData.light().copyWith(

  primaryColor: Colors.lightBlueAccent.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.lightBlueAccent.shade700,
  ),

);

ThemeData yellowTheme = ThemeData.light().copyWith(

  primaryColor: Colors.yellow.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.yellow.shade700,
  ),

);

ThemeData orangeTheme = ThemeData.light().copyWith(

  primaryColor: Colors.orange.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.orange.shade700,
  ),

);

ThemeData deepOrangeTheme = ThemeData.light().copyWith(

  primaryColor: Colors.deepOrange.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.deepOrange.shade700,
  ),

);

ThemeData redTheme = ThemeData.light().copyWith(

  primaryColor: Colors.red.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.red.shade700,
  ),

);

ThemeData pinkTheme = ThemeData.light().copyWith(

  primaryColor: Colors.pink.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.pink.shade700,
  ),

);

ThemeData purpleTheme = ThemeData.light().copyWith(

  primaryColor: Colors.purple.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.purple.shade700,
  ),

);

ThemeData deepPurpleTheme = ThemeData.light().copyWith(

  primaryColor: Colors.deepPurple.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.deepPurple.shade700,
  ),

);

ThemeData brownTheme = ThemeData.light().copyWith(

  primaryColor: Colors.brown.shade700,
  appBarTheme: AppBarTheme(
    color: Colors.brown.shade700,
  ),

);

ThemeData white30Theme = ThemeData.light().copyWith(

  primaryColor: Colors.white30,
  appBarTheme: AppBarTheme(
    color: Colors.white30,
  ),

);

ThemeData black45Theme = ThemeData.light().copyWith(

  primaryColor: Colors.black45,
  appBarTheme: AppBarTheme(
    color: Colors.black45,
  ),

);


class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = tealTheme;
  ThemeType _themeType = ThemeType.Teal;

  toggleTheme() {
    if (_themeType == ThemeType.Teal) {
      currentTheme = tealTheme;
      _themeType = ThemeType.Teal;
      print('Teal');
       notifyListeners();
    }

    if (_themeType == ThemeType.Green) {
      currentTheme = greenTheme;
      _themeType = ThemeType.Green;
      print('Green');
       notifyListeners();
    }
    if (_themeType == ThemeType.LightGreen) {
      currentTheme = lightGreenTheme;
      _themeType = ThemeType.LightGreen;
      print('LightGreen');
       notifyListeners();
    }

    if (_themeType == ThemeType.LightGreenAccent) {
      currentTheme = lightGreenAccentTheme;
      _themeType = ThemeType.LightGreenAccent;
      print('LightGreenAccent');
      notifyListeners();
    }

    if (_themeType == ThemeType.Lime) {
      currentTheme = limeTheme;
      _themeType = ThemeType.Lime;
      print('Lime');
      notifyListeners();
    }
    if (_themeType == ThemeType.Blue) {
      currentTheme = blueTheme;
      _themeType = ThemeType.Blue;
      print('Blue');
      notifyListeners();
    }
    if (_themeType == ThemeType.LightBlueAccent) {
      currentTheme = lightBlueAccentTheme;
      _themeType = ThemeType.LightBlueAccent;
      print('LightBlueAccent');
      notifyListeners();
    }

    if (_themeType == ThemeType.Yellow) {
      currentTheme = yellowTheme;
      _themeType = ThemeType.Yellow;
      print('Yellow');
      notifyListeners();
    }
    if (_themeType == ThemeType.Orange) {
      currentTheme = orangeTheme;
      _themeType = ThemeType.Orange;
      print('Orange');
      notifyListeners();
    }
    if (_themeType == ThemeType.DeepOrange) {
      currentTheme = deepOrangeTheme;
      _themeType = ThemeType.DeepOrange;
      print('DeepOrange');
      notifyListeners();
    }

    if (_themeType == ThemeType.Red) {
      currentTheme = redTheme;
      _themeType = ThemeType.Red;
      print('Red');
      notifyListeners();
    }
    if (_themeType == ThemeType.Pink) {
      currentTheme = pinkTheme;
      _themeType = ThemeType.Pink;
      print('Pink');
      notifyListeners();
    }
    if (_themeType == ThemeType.Purple) {
      currentTheme = purpleTheme;
      _themeType = ThemeType.Pink;
      print('Purple');
      notifyListeners();
    }
    if (_themeType == ThemeType.DeepPurple) {
      currentTheme = deepPurpleTheme;
      _themeType = ThemeType.Pink;
      print('DeepPurple');
      notifyListeners();
    }
    if (_themeType == ThemeType.Brown) {
      currentTheme = brownTheme;
      _themeType = ThemeType.Brown;
      print('Brown');
      notifyListeners();
    }
    if (_themeType == ThemeType.White30) {
      currentTheme = white30Theme;
      _themeType = ThemeType.White30;
      print('White30');
      notifyListeners();
    }
    if (_themeType == ThemeType.Black45) {
      currentTheme = black45Theme;
      _themeType = ThemeType.Black45;
      print('Black45');
      notifyListeners();
    }
  }

  ThemeType getEnumValue(){
    return _themeType;
  }

  void changeEnumValue(ThemeType newThemeType){
   _themeType = newThemeType;
   toggleTheme();
  }

}