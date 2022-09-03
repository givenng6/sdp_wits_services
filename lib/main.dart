import 'dart:ui';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'SignupAndLogin/app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wits Services',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        duration: 1000,
        splashIconSize: window.physicalSize.width-100,
        animationDuration: const Duration(milliseconds: 1000),
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: const Color(0xff003b5c),
        splash: Image.asset("assets/white_logo_nb.png"),
        nextScreen: const App(),
      ),
    );
  }
}