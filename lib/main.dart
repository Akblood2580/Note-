

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:note_app/chat.dart';
import 'package:note_app/des.dart';
import 'package:note_app/fetch.dart';
import 'package:note_app/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/signin.dart';
import 'package:note_app/splash.dart';

main()async{
  
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Fetch(),
       title: "NOTE",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
    );
  }
}