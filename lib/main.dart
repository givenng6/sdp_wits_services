import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Firebase/auth_service.dart';
import 'app.dart';
import 'Firebase/firebase_options.dart';
import './StudentsApp/Home/Home.dart';

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
      home: Home()//AuthService().handleAuthState(),
    );
  }
}