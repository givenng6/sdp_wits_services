import 'package:flutter/material.dart';
import 'package:sdp_wits_services/SignupAndLogin/StaffSignin.dart';

import 'StudentsSignin.dart';

class VerificationMessage extends StatefulWidget {
  final String kind;
  const VerificationMessage({Key? key, required this.kind}) : super(key: key);

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
                    const Spacer(),
                    ElevatedButton(onPressed: (){
                      if(widget.kind == "student"){
                        debugPrint("Going to students login screen");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentsLoginScreen()));
                      }else if(widget.kind == "staff"){
                        debugPrint("Going to staff login screen");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const StaffLoginScreen()));
                      }
                    }, child: const Text('Go Back To Login'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
