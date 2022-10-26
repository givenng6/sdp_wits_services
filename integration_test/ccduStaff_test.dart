import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sdp_wits_services/StaffApp/CCDU/ccdu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/globals.dart' as main_globals;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end ccdu test", () {
    testWidgets("StaffCCDU", _ccduStaffTests);
  });
}

Future<void> _ccduStaffTests(WidgetTester tester) async {
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('department', 'CCDU');

  await main_globals.getSharedPreferences();
  String url = "https://sdpwitsservices-production.up.railway.app";

  await http.get(Uri.parse("$url/ccdu/TestSetup/Init"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });

  await tester.pumpWidget(const MaterialApp(home: CCDU()));
  expect(find.text("No Upcoming Appointments"), findsOneWidget);
  await tester.pump(const Duration(seconds: 1));

  final ccduIcon = find.byIcon(Icons.psychology_outlined);
  final ccduText = find.text("CCDU");
  final profile = find.text("S");
  final allTab = find.text("All");
  final acceptedTab = find.text("Accepted");

  expect(ccduIcon, findsOneWidget);
  expect(ccduText, findsOneWidget);
  expect(profile, findsOneWidget);
  expect(allTab, findsOneWidget);
  expect(acceptedTab, findsOneWidget);

  await tester.tap(allTab);
  await tester.pump(const Duration(seconds: 4));

  //All card
  expect(find.text("Lindokuhle Mabena"), findsWidgets);
  expect(find.text("Date: 07/11/2022"), findsWidgets);
  expect(find.text("Time: 08:00-09:00"), findsWidgets);
  expect(find.text("Platform: Online"), findsWidgets);
  expect(find.text("Description"), findsWidgets);
  expect(find.text("Some description"), findsWidgets);
  expect(find.text("ACCEPT"), findsWidgets);
  expect(find.text("Other Bookings"), findsOneWidget);

  await tester.tap(find.byKey(const Key("test1btn")));
  await tester.pump(const Duration(seconds: 2));

  expect(find.text("Link"), findsWidgets);
  final submitBtn = find.text("Submit");
  expect(submitBtn, findsOneWidget);

  await tester.enterText(find.byKey(const Key("linkTextField")), "Some link");
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.tap(submitBtn);
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(seconds: 4));

  expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
  expect(find.text("Appointment confirmed"), findsOneWidget);
  expect(find.text("Close"), findsOneWidget);

  await tester.tap(find.text("Close"));
  await tester.pump(const Duration(seconds: 3));

  await tester.tap(acceptedTab);
  await tester.pump(const Duration(seconds: 4));

  expect(find.text("Lindokuhle Mabena"), findsWidgets);
  expect(find.text("Date: 07/11/2022"), findsWidgets);
  expect(find.text("Time: 08:00-09:00"), findsWidgets);
  expect(find.text("Platform: Online"), findsWidgets);
  expect(find.text("Description"), findsWidgets);
  expect(find.text("Some description"), findsWidgets);

  await tester.pump(const Duration(seconds: 1));

  await tester.tap(profile);
  await tester.pump(const Duration(seconds: 1));


  await http.get(Uri.parse("$url/ccdu/TestSetup/Cleanup"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });
  await tester.pump(const Duration(seconds: 1));
  preferences.clear();
}
