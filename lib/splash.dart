import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:note_app/login.dart';
class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: AnimatedSplashScreen(
        splash:AssetImage("assest/image/logo.png").assetName,
        nextScreen:LOgin(),
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: Colors.amber,
        splashIconSize: 180,
        animationDuration: Duration(seconds: 1),),
        )
        

      
    );
  }
}

