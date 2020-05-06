import 'package:flutter/material.dart';
import 'package:flutternoteapp/Misc/TabsFile.dart';
import 'package:provider/provider.dart';
import 'package:flutternoteapp/Firebase/authentication.dart';
import 'package:flutternoteapp/Authentication/SwitchAuthenticationState.dart';
import 'Misc/Themes.dart';
import 'NewNote/NewNote.dart';
import 'Authentication/Wrapper.dart';
import 'Options/SettingsPage.dart';
import 'Authentication/LoginPage.dart';
import 'Authentication/Registration.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(), child: MyApp()));

//void main() => runApp(MyApp());

//TODO: For graphs use chart package

class MyApp extends StatelessWidget {

  //TODO: Shared pref load on start was deactivated because it was not working properly
  //TODO: On Login, whitespaces are added to the string check. This uses a special package and not regex. Must be fixed
  //Known issues: 1. The delete function deletes only the top layer, the children still exist in the database, but will never be used again
  // Make delete pop up a screen to insert all passwords for the locked folders below. Also inform the user how many files will be deleted, and delete all children from database
  //2. Shared preferences is not loading properly the last instance of itself.
  //3. Missing text, errors and logo
  //4. Count elements function is broken and thus it was deactivated for now

  //To implement later on: The firebase is connected, but the cloud is not properly implemented so that you can download lost data



  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: Provider.of<ThemeModel>(context).currentTheme,
        title: 'Flutter Demo',
        initialRoute:  Wrapper.id,
        routes: {
          Wrapper.id: (context) => Wrapper(),
          LoginPage.id: (context) => LoginPage(),
          Registration.id: (context) => Registration(),
          SettingsPage.id: (context) => SettingsPage(),
          NewNote.id : (context) => NewNote(),
          TabsFile.id : (context) =>TabsFile(),
          //Notes.id : (context) => Notes(),
          SwitchAuthenticationState.id: (context) =>SwitchAuthenticationState(),
        },
      ),
    );
  }
}
