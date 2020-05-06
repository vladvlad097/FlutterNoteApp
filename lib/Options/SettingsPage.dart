import 'package:flutter/material.dart';
import 'package:flutternoteapp/Misc/Themes.dart';
import 'package:provider/provider.dart';
import 'package:flutternoteapp/shared_preferences_app.dart';
import 'package:flutternoteapp/shared_preferences_app.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:flutternoteapp/Misc/ThemeList.dart';

//TODO: Transparent background for list

class SettingsPage extends StatefulWidget {
  static const id = "settings_page";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}




class SharedPref{
  saveThemeToSharedPref(String key, ThemeOptions value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value.toJson()));
    print('dataSaved');
    print(prefs.getString(key));
  }

  readThemeFromSharedPref(String key) async{
    final prefs = await SharedPreferences.getInstance();
    print('dataLoaded');
    return json.decode((prefs.getString(key)));
  }
}



class _SettingsPageState extends State<SettingsPage> {

  ThemeOptions dropdownValue;
  SharedPref sharedPref = SharedPref();

  loadSharedPrefs() async {
    try{
      ThemeOptions currentTheme = ThemeOptions.fromJson(await sharedPref.readThemeFromSharedPref('currentTheme'));
      setState(() {
        print("is being copyed");
        dropdownValue = currentTheme;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    SharedPref sharedPref = SharedPref();
    dropdownValue =themes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsPage'),
      ),
      body: Column(
       children: <Widget>[
         Container(
           child: DropdownButton<ThemeOptions>(
             value: dropdownValue,
             icon: Icon(Icons.arrow_downward),
             iconSize: 24,
             elevation: 16,
             style: TextStyle(
                 color: Colors.deepPurple
             ),
             underline: Container(
               height: 0.0,
               color: Colors.deepPurpleAccent,
             ),
             onChanged: (ThemeOptions newValue) {
               setState(() {
                 dropdownValue = newValue;
                 sharedPref.saveThemeToSharedPref("currentTheme", dropdownValue);
                 Provider.of<ThemeModel>(context, listen: false).changeEnumValue(dropdownValue.enumTheme);
               });
             },
             items: themes.map((ThemeOptions colorThemeInstance) {
               return DropdownMenuItem<ThemeOptions>(
                 value: colorThemeInstance,
                 child: CircleAvatar(
                   backgroundColor: colorThemeInstance.themeColor,
                 ),
               );
             })
                 .toList(),
           ),
         ),
         SizedBox(height: 20.0,),
       ],
      ),
    );
  }
}




//loadSharedPrefs();
//Provider.of<ThemeModel>(context, listen: false).changeEnumValue(dropdownValue.enumTheme);

