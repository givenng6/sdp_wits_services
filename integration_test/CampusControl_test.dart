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
    testWidgets("Campus Control", _campusControlTest);
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
  // debugPrint("hh ${localGlobals.vehicles}");

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
  await tester.pump(const Duration(seconds: 3));

  final findNumPlate = find.text("- KSD 731 GP");
  expect(findNumPlate,findsOneWidget);
  final findCarName = find.text("Avanza");
  expect(findCarName,findsWidgets);


  await tester.tap(find.byKey(const Key("KSD 731 GP")));
  await tester.pumpAndSettle(const Duration(seconds: 3));

  final floatingActionBtn = find.byIcon(Icons.send);
  expect(floatingActionBtn,findsOneWidget);

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final findCampusName = find.text("Business School");
  expect(findCampusName,findsOneWidget);

  await tester.tap(find.text("Health Campus"));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(findCampusName);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  expect(floatingActionBtn,findsOneWidget);

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle();

  // await localGlobals.GetStudents();
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  final findStudent1Name = find.text("Student One");
  final findStudent1res = find.text("- Student Digz");

  final findStudent2Name = find.text("Student Two");

  final findStudent3Name = find.text("Student One");
  final findStudent3res = find.text("- J-One");

  expect(findStudent1Name,findsWidgets);
  expect(findStudent1res,findsWidgets);

  expect(findStudent2Name,findsWidgets);

  expect(findStudent3Name,findsWidgets);
  expect(findStudent3res,findsWidgets);

  await tester.tap(find.byKey(const Key("student1@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("student2@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("student3@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final findStart = find.byKey(const Key("start"));

  expect(findStart,findsOneWidget);

  await tester.tap(findStart);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final findStudentDigz = find.text("Student Digz");
  final findJOne = find.text("J-One");

  expect(findStudentDigz,findsWidgets);
  expect(findJOne,findsWidgets);

  await tester.tap(findStudentDigz);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(findJOne);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  expect(floatingActionBtn,findsWidgets);

  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  //End Shift
  final findEndShiftBtn = find.byIcon(Icons.exit_to_app);
  expect(findEndShiftBtn,findsWidgets);

  //Open bottom sheet
  await tester.tap(findEndShiftBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final conText = find.text("Are you sure you want to end shift?");
  expect(conText,findsWidgets);

  final endShiftBtn = find.text("End Shift");
  expect(endShiftBtn,findsWidgets);
  expect(find.text("Cancel"),findsWidgets);

  await tester.tap(endShiftBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));


  // await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}