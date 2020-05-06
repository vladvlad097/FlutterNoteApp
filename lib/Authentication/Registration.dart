import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutternoteapp/Firebase/authentication.dart';
import 'package:flutternoteapp/Misc/LoadingPage.dart';


//TODO: Copy design from main app
//TODO: make theme functionality


class Registration extends StatefulWidget {
  static const id = "registration";

  final Function toggleView;
  Registration({this.toggleView});
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String error= '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    return isLoading == true? Loading() : Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register on TheApp'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Login'),
            onPressed: (){
              print('move scenes');
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (val) => EmailValidator.validate(val) ? null: 'Enter a valid email',
                onChanged: (val){
                   setState(() => email = val);
                },
                onSaved: (val) => email = val,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                validator: (val) => val.length > 6 ? null: 'Password is to short. It must be more than 6 chars', //TODO: make a more complex password checking
                onChanged: (val){
                  setState(()  => password = val);
                },
                onSaved: (val) => password = val,
                //showCursor: true,
                obscureText: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0,),
              FlatButton(
                color: Colors.orange,
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      isLoading = true;
                    });
                    dynamic result = await _auth.registerWithEmailPass(email, password);
                    if(result == null)
                      {
                        setState(() {
                          isLoading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                 }
              },
                child: Text('REGISTER'),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
