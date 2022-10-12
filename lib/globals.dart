library globals;

import 'package:flutter/cupertino.dart';
import 'package:sdp_wits_services/SignupAndLogin/app.dart';
import 'package:sdp_wits_services/StaffApp/Buses/buses_main.dart';
import 'package:sdp_wits_services/StaffApp/Dining/mealSelectionPage.dart';
import 'package:sdp_wits_services/StaffApp/StaffPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StudentsApp/Home/Start.dart';

String? username;
String? email;
String? kind;
String? department;

Future getSharedPreferences() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  username = sharedPreferences.getString('username');
  email = sharedPreferences.getString('email');
  kind = sharedPreferences.getString('kind');
  department = sharedPreferences.getString('department');
  debugPrint('called');
}

Future getData() async {
  if (username != "" && username != null && kind == 'Student') {
    return Start(email: email!, username: username!);
  }
  else if (username != "" && username != null && kind == 'Staff' && department == 'Bus Services') {
    return const BusesMain();
  }
  else if (username != "" && username != null && kind == 'Staff' && department == 'Dining Services') {
    return const mealSelecionPage();
  }
  else if (username != "" && username != null && kind == 'Staff') {
    return const StaffPage();
  }
  else{
    return const App();
  }
}