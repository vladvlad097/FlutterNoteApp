import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'Registration.dart';


class SwitchAuthenticationState extends StatefulWidget {
 static const id = "switch_authenticate";

  @override
  _SwitchAuthenticationStateState createState() => _SwitchAuthenticationStateState();
}

class _SwitchAuthenticationStateState extends State<SwitchAuthenticationState> {

  bool registerOrLogin = false;
  void toggleView(){
    setState(()  => registerOrLogin = ! registerOrLogin);
  }

  @override
  Widget build(BuildContext context) {
    if(registerOrLogin){
      print('call login');
      return LoginPage(toggleView: toggleView);
    }else{
      print('call register');
      return Registration(toggleView: toggleView);

    }
  }
}
