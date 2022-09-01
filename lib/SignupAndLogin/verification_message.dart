import 'package:flutter/material.dart';

import 'StudentsSignin.dart';

class VerificationMessage extends StatefulWidget {
  const VerificationMessage({Key? key}) : super(key: key);

  @override
  State<VerificationMessage> createState() => _VerificationMessageState();
}

class _VerificationMessageState extends State<VerificationMessage> {
  String message = 'A verifacation link has been sent to your emails. '
      'Click on the link to verify your email. \n Also check in your spam email.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 350,
          // padding: EdgeInsets.all(30),
          child: Card(
            color: Colors.grey[100],
            child: Container(
                margin: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Center(child: Text(message)),
                    Spacer(),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentsLoginScreen()));
                    }, child: Text('Go Back To Login'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
