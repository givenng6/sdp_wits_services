import 'package:flutter/material.dart';
import 'package:sdp_wits_services/SignupAndLogin/StudentsSignin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SudentsApp/Home/Home.dart';
import 'StaffSignin.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString('username');
    String? email = sharedPreferences.getString('email');
    if(username != "" || username != null){
      _navigateToHome(email, username);
    }
  }

  _navigateToHome(email, username){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                Home(email, username)),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/uni.jpeg'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: const Image(image: AssetImage('assets/white_logo_nb.png'))),
            Container(
                width: 300,
                height: 55,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                    key: const Key('Continue as Student'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff003b5c)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentsLoginScreen()));
                    },
                    child: const Text("Continue as Student",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff7393B3))))),
            Container(
                width: 300,
                height: 55,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                    key: const Key('Continue as Staff'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff003b5c)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StaffLoginScreen()));
                    },
                    child: const Text(
                      "Continue as Staff",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xff7393B3)),
                    )))
          ],
        ),
      ),
    );
  }
}
