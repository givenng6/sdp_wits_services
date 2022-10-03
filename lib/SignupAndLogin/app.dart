import 'package:flutter/material.dart';
import 'package:sdp_wits_services/SignupAndLogin/StudentsSignin.dart';
import '../StaffApp/Buses/buses_main.dart';
import '../StaffApp/Dining/mealSelectionPage.dart';
import '../StaffApp/StaffPage.dart';
import '../StudentsApp/Home/Home.dart';
import '../StudentsApp/Home/Start.dart';
import 'StaffSignin.dart';
import 'package:sdp_wits_services/globals.dart' as globals;

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
  List? routes;
  _getData() async {
    await Future.delayed(const Duration(milliseconds: 1));
    if (globals.username != "" && globals.username != null && globals.kind == 'Student') {
      _navigateToHome(globals.email, globals.username);
    }
    else if (globals.username != "" && globals.username != null && globals.kind == 'Staff' && globals.department == 'Bus Services') {
      _navigateToBusesMain();
    }
    else if (globals.username != "" && globals.username != null && globals.kind == 'Staff' && globals.department == 'Dining Services') {
      _navigateToDinningServices();
    }
    else if (globals.username != "" && globals.username != null && globals.kind == 'Staff') {
      _navigateToStaffPage();
    }
  }

  _navigateToHome(email, username) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Start()),//Home(email, username)),
        (Route<dynamic> route) => false);
  }

  _navigateToStaffPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const StaffPage()),
        (Route<dynamic> route) => false);
  }

  _navigateToDinningServices() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => mealSelecionPage()),
            (Route<dynamic> route) => false);
  }

  _navigateToBusesMain(){
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) => const BusesMain()));
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child:
                    const Image(image: AssetImage('assets/white_logo_nb.png'))),
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
