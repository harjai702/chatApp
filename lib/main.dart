import 'package:chatapp/selectprofpic.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'signup.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
void main() { runApp(new MyApp());
Firebase.initializeApp();
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home:LoginPage(),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => new HomePage(),
        '/landingpage': (BuildContext context)=> new MyApp(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/profilepic': (BuildContext context) => new SelectProfilePage(),
      },
    );
  }
}
