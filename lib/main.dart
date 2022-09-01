import 'package:flutter/material.dart';
import 'package:sdp_wits_services/SignupAndLogin/verification_message.dart';
import 'SignupAndLogin/app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'SudentsApp/Home/Home.dart';

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
      home: const App(),
    );
  }
}
