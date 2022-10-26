import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StaffApp/CCDU/ccdu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/globals.dart' as main_globals;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end ccdu test", () {
    testWidgets("StaffCCDU", _ccduTests);
  });
}

Future<void> _ccduTests(WidgetTester tester) async {
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('department', 'CCDU');

  await main_globals.getSharedPreferences();
  String url = "";

  await http.get(Uri.parse("$url/ccdu/TestSetup/Init"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"});


  await tester.pump(const Duration(seconds: 1));



  await tester.pumpWidget(MaterialApp(home: const CCDU()));


  await http.get(Uri.parse("$url/ccdu/TestSetup/Cleanup"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"});
}
