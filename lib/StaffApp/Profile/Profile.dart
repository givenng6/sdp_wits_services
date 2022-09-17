import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SignupAndLogin/app.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  void logout() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("email");
    sharedPreferences.remove("department");
    sharedPreferences.remove("dhName");
    sharedPreferences.remove("kind");
    sharedPreferences.remove("username");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const App()),
            (Route<dynamic> route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          logout();
        }, child: Text("Logout")),
      ),
    );
  }
}
