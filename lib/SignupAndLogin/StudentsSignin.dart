import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:sdp_wits_services/SudentsApp/Home/Home.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'a@test.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class StudentsLoginScreen extends StatelessWidget {
  const StudentsLoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
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
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
