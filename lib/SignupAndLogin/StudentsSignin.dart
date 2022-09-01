import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:sdp_wits_services/SignupAndLogin/verification_message.dart';
import 'package:sdp_wits_services/SudentsApp/Home/Home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const users = {
  'dribbble@gmail.com': '12345',
  'a@test.com': '12345',
  'hunter@gmail.com': 'hunter',
};

String? whereFrom;
String? valid = "valid";
bool? verified;

// Uri to the API
String uri = "http://10.0.1.55:8000/";

class StudentsLoginScreen extends StatelessWidget {
  const StudentsLoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    whereFrom = "login";
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    var result =
        await http.post(Uri.parse("${uri}auth/login/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": data.name,
              "password": data.password,
            }));
    var json = jsonDecode(result.body);

    valid = json['status'];
    verified = json['verified'];

    return Future.delayed(loginTime).then((_) {
      if (valid! == "invalid") {
        return 'Email or password incorrect';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    String username = data.additionalSignupData!['username']!;
    debugPrint("username = $username");
    whereFrom = "signup";
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    var result = await http.post(
      Uri.parse("${uri}auth/signUp/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email"   : data.name as String,
        "password": data.password as String,
        "kind"    : "student",
        "username": username,
      })
    );
    var json = jsonDecode(result.body);
    valid = json['status'] as String;
    debugPrint(json['status']);
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) async {
    debugPrint('Name: $name');
    var result =
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
    if (name == null || name == ""){
      error = "Username is required";
    }
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Wits Services',
      theme: LoginTheme(
        primaryColor: const Color(0xff003b5c),
        accentColor: Colors.white,
      ),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        if ((whereFrom! == "signup" && valid! == "valid") ||
            (whereFrom! == "login" && valid! == "valid" && !verified!)) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const VerificationMessage()),
              (Route<dynamic> route) => false);
        } else if (whereFrom! == "login" && valid! == "valid" && verified!) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Home()),
              (Route<dynamic> route) => false);
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
          recoverPasswordDescription:
              "We will send a link to the email account.",
          recoverPasswordSuccess: 'If your account exists email has been sent!',
          additionalSignUpFormDescription:
              "Enter your username in this form to complete signup"),
    );
  }
}

// 2375736@students.wits.ac.za
// 1234567
