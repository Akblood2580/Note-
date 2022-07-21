import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/customWidget.dart/dropDrownButton.dart';
import 'package:note_app/deliveryboy.dart';
import 'package:note_app/map.dart';
import 'package:note_app/splash.dart';
import 'package:note_app/userOrder.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DropdownButtons(),
      title: "NOTE",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
