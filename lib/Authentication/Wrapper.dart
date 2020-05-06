import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutternoteapp/Firebase/authentication.dart';
import 'package:flutternoteapp/Authentication/SwitchAuthenticationState.dart';

import 'package:flutternoteapp/Options/SettingsPage.dart';
import 'package:flutternoteapp/Misc/TabsFile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutternoteapp/Misc/ThemeList.dart';
import 'package:flutternoteapp/Misc/Themes.dart';


class Wrapper extends StatelessWidget {
  static const id = "wrapper";
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

//    bool checkedSharedPref = false;
//
//    if(checkedSharedPref == false){
//      SharedPref sharedPref = SharedPref();
//      ThemeOptions dropdownValue;
//
//      loadSharedPrefs() async {
//        try {
//          ThemeOptions currentTheme = ThemeOptions.fromJson(
//              await sharedPref.readThemeFromSharedPref('currentTheme'));
//          print("is being copyed");
//          dropdownValue = currentTheme;
//        } catch(e){
//          print(e);
//        }
//      }
//
//      checkedSharedPref = true;
//      loadSharedPrefs();
//       Provider.of<ThemeModel>(context, listen: false).toggleTheme();
//    }

    if(user == null){
      print('user is $user');
     return SwitchAuthenticationState();
    }else{
      print('user is $user');
      return TabsFile();
    }

    //return TabsFile();
  }
}
