import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sdp_wits_services/Firebase/auth_service.dart';
import 'package:sdp_wits_services/StudentsApp/AppBar.dart';
import './StudentsApp/Home/Home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Sign In'),
        ),
        backgroundColor: const Color(0xff115571),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  String btn = 'SignInAsStudent';
                  AuthService().signInWithGoogle(btn);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff115571)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )
                    )
                ),
                child: const Text('Sign In As A Student'),
              ),
            ),
            Container(
              width: 200,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  String btn = 'SignInAsStaff';
                  AuthService().signInWithGoogle(btn);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff115571)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                  )
                ),
                child: const Text('Sign In As Staff'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
