import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:sdp_wits_services/StaffApp/Dining/mealSelectionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../StaffApp/Buses/buses_main.dart';
import '../StaffApp/StaffPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? valid;
bool? verified;

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

String? username, email, kind,uid;

class StaffLoginScreen extends StatelessWidget {
  const StaffLoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<void> getDep(String email) async{

    var result = await http.post(Uri.parse("http://192.168.42.155:5000/Users/GetDep"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
        }));
    var json = jsonDecode(result.body);
    debugPrint("");

    if(json["status"]=="exists"){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("department",json["department"]);
      if(json["department"] == "Dining Services"){
        sharedPreferences.setString("dhName",json["dhName"]);
      }
    }



  }

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    for (int i = 0; i < data.name.length; i++) {
      if (data.name[i] == '@') {
        String emailExtension = data.name.substring(i, data.name.length);
        if (emailExtension == '@students.wits.ac.za') {
          return Future.delayed(loginTime).then((_) {
            return 'Come On, Really?\n You Know You Should Login As A Student';
          });
        } else if (emailExtension == '@wits.ac.za') {
          var result = await http.post(Uri.parse("${uri}auth/login/"),
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

          if (valid == 'valid') {
            await getDep(data.name);
            username = json['username'];
            email = json['email'];
            uid = json['uid'];
          }


          return Future.delayed(loginTime).then((_) {
            if (valid == "valid" && !verified!) {
              return "Account Is Not Verified\n A Verification Link Has Been Sent To Your Email Account. "
                  "Also Check In Your SPAM Emails Too";
            } else if (valid! == "invalid") {
              return 'Email or password incorrect';
            }
            return null;
          });
        } else {
          return Future.delayed(loginTime).then((_) {
            return 'You Should Use Your Wits Stuff Email To Login';
          });
        }
      }
    }
    return null;
  }

  Future<String?> _signupUser(SignupData data) async {
    String username = data.additionalSignupData!['username']!;
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');


    for (int i = 0; i < data.name!.length; i++) {
      if (data.name![i] == '@') {
        String emailExtension = data.name!.substring(i, data.name!.length);
        if (emailExtension == '@students.wits.ac.za') {
          return Future.delayed(loginTime).then((_) {
            return 'You Know You Should Signup As A Student';
          });
        } else if (emailExtension == '@wits.ac.za') {
          var result = await http.post(Uri.parse("${uri}auth/signUp/"),
              headers: <String, String>{
                "Accept": "application/json",
                "Content-Type": "application/json; charset=UTF-8",
              },
              body: jsonEncode(<String, String>{
                "email": data.name as String,
                "password": data.password as String,
                "kind": "staff",
                "username": username,
              }));
          var json = jsonDecode(result.body);
          valid = json['status'] as String;
          debugPrint(json['status']);

          return Future.delayed(loginTime).then((_) {
            return null;
          });
        } else {
          return Future.delayed(loginTime).then((_) {
            return 'You Should Use Your Wits Stuff Email To Signup';
          });
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
    navigateToStaffPage(){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const StaffPage()),
              (Route<dynamic> route) => false);
    }

    handleDepartments(String dep) {

      if(dep=="Dining Services"){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>  mealSelecionPage(dateTime: DateTime.now())),
                (Route<dynamic> route) => false);
      }else if(dep=="Bus Services"){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>   const BusesMain()),
                (Route<dynamic> route) => false);
      }

    }
    return FlutterLogin(
      title: 'Wits Services',
      theme: LoginTheme(
        primaryColor: const Color(0xff003b5c),
        accentColor: Colors.white,
      ),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () async{
        if (valid! == "valid" && verified!) {
          if (valid == "valid" && verified!) {
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('username', username!);
            sharedPreferences.setString('email', email!);
            sharedPreferences.setString('kind', 'Staff');
            debugPrint('here');
            String? dep = sharedPreferences.getString("department");
            if(dep == null){
              navigateToStaffPage();
            }else{
              handleDepartments(dep);
            }
          }

        }
      },
      onRecoverPassword: _recoverPassword,
      loginAfterSignUp: false,
      scrollable: true,
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
