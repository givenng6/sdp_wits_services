library globals;

import 'package:flutter/cupertino.dart';
import 'package:sdp_wits_services/SignupAndLogin/app.dart';
import 'package:sdp_wits_services/StaffApp/Buses/buses_main.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/CampusControl.dart';
import 'package:sdp_wits_services/StaffApp/Dining/mealSelectionPage.dart';
import 'package:sdp_wits_services/StaffApp/StaffPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StaffApp/Campus Control/OnRoute.dart';
import 'StaffApp/Campus Control/onDuty.dart';
import 'StudentsApp/Home/Start.dart';

String? username;
String? email;
String? kind;
String? department;
String? driverState;

Future getSharedPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  username = sharedPreferences.getString('username');
  email = sharedPreferences.getString('email');
  kind = sharedPreferences.getString('kind');
  department = sharedPreferences.getString('department');
  driverState = sharedPreferences.getString('driverState');
}

Future getData() async {
  if (username != "" && username != null && kind == 'Student') {
    return Start(email: email!, username: username!);
  } else if (username != "" &&
      username != null &&
      kind == 'Staff' &&
      department == 'Bus Services') {
    return const BusesMain();
  } else if (username != "" &&
      username != null &&
      kind == 'Staff' &&
      department == 'Dining Services') {
    return const mealSelecionPage();
  } else if (username != "" &&
      username != null &&
      kind == 'Staff' &&
      department == 'Campus Control') {
    return const CampusControl();
    if (driverState == "onDuty") {
      return const OnDuty();
    } else if (driverState == "onRoute") {
      return const OnRoute();
    } else {
      return const CampusControl();
    }
  } else if (username != "" && username != null && kind == 'Staff') {
    return const StaffPage();
  } else {
    return const App();
  }
}
