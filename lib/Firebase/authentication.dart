import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String uid;
  User({this.uid});
}

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _checkUserInFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) =>_checkUserInFirebase(user));
    //.map(_userFromFirebaseUser) same as up
  }

  Future registerWithEmailPass(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      FirebaseUser user = result.user;
      return user.uid;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future loginWithEmailPass(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      FirebaseUser user = result.user;
      return user.uid;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e) {
      print(e.toString());
      return null;
    }
  }
}