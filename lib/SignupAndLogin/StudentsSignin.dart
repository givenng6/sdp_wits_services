import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/StudentsApp/Home/Home.dart';
import 'package:sdp_wits_services/StudentsApp/Home/Start.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? valid;
bool? verified;

// Uri to the API
String uri = "https://web-production-a9a8.up.railway.app/";


// data to send
String? username, email, uid;

class StudentsLoginScreen extends StatelessWidget {
  const StudentsLoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Duration get duration => const Duration(milliseconds: 1);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    for (int i = 0; i < data.name.length; i++) {
      if (data.name[i] == '@') {
        String emailExtension = data.name.substring(i, data.name.length);

        if (emailExtension == '@students.wits.ac.za') {
          var result = await http.post(Uri.parse("${uri}auth/login/"),
              headers: <String, String>{
                "Accept": "application/json",
                "Content-Type": "application/json; charset=UTF-8",
              },
              body: jsonEncode(<String, String>{
                "email": data.name,
                "password": data.password,
              }));
          var json = await jsonDecode(result.body);

          print(json);

          valid = json['status'];
          verified = json['verified'];

          if (valid == 'valid') {
            username = json['username'];
            email = json['email'];
            uid = json['uid'];
          }

          return Future.delayed(loginTime).then((_) {
            if (valid == "valid" && !verified!) {
              return "Account Is Not Verified"
                  "\nLink To Verify Has Been Sent To ${data.name}."
                  "\nAlso Check In Your SPAM Emails Too";
            } else if (valid! == "invalid") {
              return 'Email or password incorrect';
            }
            return null;
          });
        } else if (emailExtension == '@wits.ac.za') {
          return Future.delayed(loginTime).then((_) {
            return 'You Should Log In As Staff!';
          });
        } else {
          return 'You Should Use Your Wits Student Email To Login';
        }
      }
    }
    return null;
  }

  Future<String?> _signupUser(SignupData data) async {
    String username = data.additionalSignupData!['username']!;
    debugPrint("username = $username");
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    for (int i = 0; i < data.name!.length; i++) {
      if (data.name![i] == '@') {
        String emailExtension = data.name!.substring(i, data.name!.length);

        if (emailExtension == '@students.wits.ac.za') {
          var result = await http.post(Uri.parse("${uri}auth/signUp/"),
              headers: <String, String>{
                "Accept": "application/json",
                "Content-Type": "application/json; charset=UTF-8",
              },
              body: jsonEncode(<String, String>{
                "email": data.name as String,
                "password": data.password as String,
                "kind": "student",
                "username": username,
              },
              ));
          var json = await jsonDecode(result.body);
          valid = json['status'] as String;
          debugPrint(json['status']);
          return Future.delayed(loginTime).then((_) {
            return null;
          });
        }
        else if (emailExtension == '@wits.ac.za') {
          return Future.delayed(loginTime).then((_) {
            return 'You Should Signup As Staff!';
          });
        } else {
          return 'You Should Use Your Wits Student Email To Signup!';
        }
      }
    }
    return null;

  }

  Future<String?> _recoverPassword(String name) async {
    debugPrint('Name: $name');
    await http.post(Uri.parse("${uri}auth/reset/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": name,
        }));
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  String? _nameValidator(String? name) {
    debugPrint('Name: $name');
    String? error;
    if (name == null || name == "") {
      error = "Username is required!";
    }
    return error;
  }

  @override
  Widget build(BuildContext context) {
    navigateToHome(){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  //Home(email!, username!)),
                  Start(email: email!, username: username!)),
              (Route<dynamic> route) => false);
    }

    return FlutterLogin(
      key: const Key('loginPage'),
      title: 'Wits Services',
      theme: LoginTheme(
        primaryColor: const Color(0xff003b5c),
        accentColor: Colors.white,
      ),
      scrollable: true,
      onLogin: _authUser,
      onSignup: _signupUser,
      loginAfterSignUp: false,
      onSubmitAnimationCompleted: () async{
        if (valid == "valid" && verified!) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('username', username!);
          sharedPreferences.setString('email', email!);
          sharedPreferences.setString('kind', "Student");
          sharedPreferences.setStringList("scheduledEvents", []);
          sharedPreferences.setStringList("scheduledCCDU", []);
          sharedPreferences.setBool('isDailyNotified', false);
          debugPrint('here');
          navigateToHome();
        }
      },
      onRecoverPassword: _recoverPassword,
      additionalSignupFields: [
        UserFormField(
          keyName: 'username',
          userType: LoginUserType.name,
          displayName: "Username",
          fieldValidator: _nameValidator,
        ),
      ],
      messages: LoginMessages(
        recoverPasswordDescription: "We will send a link to the email account.",
        recoverPasswordSuccess: 'If your account exists email has been sent!',
        additionalSignUpFormDescription:
            "Enter your username in this form to complete signup",
        signUpSuccess: "A verification link has been sent."
            "\nCHECK IN YOUR SPAM EMAILS TOO!!!",
      ),
    );
  }
}
