import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/CampusControl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/globals.dart' as globals;
import 'package:sdp_wits_services/StaffApp/Campus Control/CampusControlGlobals.dart' as localGlobals;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end dashboard test", () {
    testWidgets("Campus Cotrol", _campusControlTest);
  });
}

Future<void> _campusControlTest(WidgetTester tester) async{
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('department','Campus Control');

  await globals.getSharedPreferences();

  await tester.pump(const Duration(seconds: 1));

  await tester.pumpWidget( MaterialApp(home: CampusControl()));

  await localGlobals.GetVehicles();
  debugPrint("hh ${localGlobals.vehicles}");

  await tester.pumpAndSettle();

  // await tester.pump(const Duration(seconds: 6));

  final findCardItem = find.text('Campus Control');
  final findSelectDH = find.text("Vehicles");
  final findUserName = find.text("S");
  final findIcon = find.byIcon(Icons.security);




  expect(findCardItem, findsOneWidget);
  expect(findSelectDH, findsOneWidget);
  expect(findUserName, findsOneWidget);

  expect(findIcon, findsOneWidget);
  await tester.pump(const Duration(seconds: 6));

  final findNumPlate = find.text("- KSD 731 GP");
  expect(findNumPlate,findsOneWidget);
  final findCarName = find.text("Avanza");
  expect(findCarName,findsWidgets);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}