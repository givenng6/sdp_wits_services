library globals;

import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sdp_wits_services/SignupAndLogin/app.dart';
import 'package:sdp_wits_services/StaffApp/Buses/View/buses_main.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/CampusControl.dart';
import 'package:sdp_wits_services/StaffApp/Dining/mealSelectionPage.dart';
import 'package:sdp_wits_services/StaffApp/StaffPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StaffApp/CCDU/CCDU.dart';
import 'StudentsApp/Home/Start.dart';

String? username;
String? email;
String? kind;
String? department;
String? driverState;
String? deviceID;

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
  }
  else if (username != "" &&
      username != null &&
      kind == 'Staff' &&
      department == 'CCDU') {
    return const CCDU();

  }else if (username != "" && username != null && kind == 'Staff') {
    return const StaffPage();
  } else {
    return const App();
  }
}

Future<void> initPlatform()async{
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  // OneSignal.shared.setRequiresUserPrivacyConsent(true);
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    debugPrint("Accepted permission: $accepted");
  });
  await OneSignal.shared.setAppId("cf748ced-65c8-4d6b-bbb0-8757e694fe3f");
  await OneSignal.shared.getDeviceState().then(
          (value)  {
        debugPrint("Id: ${value!.userId}");
        deviceID = value.userId;
      }
  );
}
