import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdp_wits_services/main.dart' as app;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';

void main() {
  group('Stuff App main test', () {
    testWidgets("Stuff app", _staffTest);
  });
}

Future<void> _staffTest(WidgetTester tester) async {
  app.main();
  await login("a2355285@wits.ac.za", "2355285", tester);

  //CCDU

  String url = "https://sdpwitsservices-production.up.railway.app";

  await http.get(Uri.parse("$url/ccdu/TestSetup/Init"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });

  await tester.pump(const Duration(seconds: 1));

  final profile = find.text("S");
  final allTab = find.text("All");
  final acceptedTab = find.text("Accepted");

  await tester.tap(allTab);
  await tester.pump(const Duration(seconds: 4));

  //All card
  await tester.tap(find.byKey(const Key("test1btn")));
  await tester.pump(const Duration(seconds: 2));

  final submitBtn = find.text("Submit");

  await tester.enterText(find.byKey(const Key("linkTextField")), "Some link");
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.tap(submitBtn);
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(seconds: 4));

  await tester.tap(find.text("Close"));
  await tester.pump(const Duration(seconds: 3));

  await tester.tap(acceptedTab);
  await tester.pump(const Duration(seconds: 3));

  http.get(Uri.parse("$url/ccdu/TestSetup/Cleanup"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8"
  });

  await logout(profile, tester);
  await http.post(Uri.parse("$url/tempRoutes/RemoveDep"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email": "a2355285@wits.ac.za"
      }));
  await login("a2355285@wits.ac.za", "2355285", tester);

  await tester.pump(const Duration(seconds: 1));

  // Dining
}

Future<void> logout(accountIcon, tester) async {
  await tester.tap(accountIcon);
  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.byKey(const Key("Logout")));
  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text("Sign Out"));
  await tester.pump(const Duration(seconds: 2));
}

Future<void> login(String email, String password, tester) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStaff = find.text('Continue as Staff');

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), 'a2355285@wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2355285');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('LOGIN'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
}
