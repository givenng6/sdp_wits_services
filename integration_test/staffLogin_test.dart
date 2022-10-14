import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/SignupAndLogin/StaffSignin.dart';
import 'package:sdp_wits_services/StaffApp/Dining/SelectOptionItems.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StaffApp/SelectDH.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sdp_wits_services/globals.dart' as globals;

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end dashboard test", () {
    testWidgets("stuff SignUp ", _staffSignupTest);
    testWidgets("stuff Recover ", _staffRecoverTest);
    testWidgets("stuff Login", _staffloginTest);

  });
}

Future<void> _staffloginTest(WidgetTester tester) async {

  await tester.pumpWidget(HookBuilder(builder: (context) {

    return const MaterialApp(home: StaffLoginScreen());
  }));
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 3));

  final email = findNameTextField();
  final password = findPasswordTextField();
  final loginbtn = find.text("LOGIN");

  expect(email,findsWidgets);
  expect(password,findsWidgets);
  expect(loginbtn,findsWidgets);

  // //student email
  await tester.enterText(email, "");
  await tester.enterText(email, "23552855@students.wits.ac.za");
  await tester.enterText(password, "23552855");
  await tester.tap(loginbtn);
  await tester.pumpAndSettle();

  //Incorrect password
  await tester.enterText(email, "");
  await tester.enterText(email, "a2355285@wits.ac.za");
  await tester.enterText(password, "23555");
  await tester.tap(loginbtn);
  await tester.pumpAndSettle();

  //Wrong email extension
  await tester.enterText(email, "");
  await tester.enterText(email, "23552855@gmail.com");
  await tester.enterText(password, "235552855");
  await tester.tap(loginbtn);
  await tester.pumpAndSettle();

  //Should work
  await tester.enterText(email, "");
  await tester.enterText(email, "a2355285@wits.ac.za");
  await tester.enterText(password, "2355285");
  await tester.tap(loginbtn);
  await tester.pumpAndSettle();

}

Future<void> _staffSignupTest(WidgetTester tester) async {

  await tester.pumpWidget(HookBuilder(builder: (context) {

    return const MaterialApp(home: StaffLoginScreen());
  }));
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 3));

  final email = findNameTextField();
  final password = findPasswordTextField();
  final confirmPassword = findConfirmPasswordTextField();
  final signupBtn = find.text("SIGNUP");



  expect(email,findsWidgets);
  expect(password,findsWidgets);
  expect(confirmPassword,findsWidgets);
  expect(signupBtn,findsWidgets);

  await tester.tap(signupBtn);
  await tester.pumpAndSettle();

  await tester.enterText(email, "23552855@students.wits.ac.za");
  await tester.enterText(password, "23552855");
  await tester.enterText(confirmPassword, "23552855");
  await tester.tap(signupBtn);
  await tester.pumpAndSettle(const Duration(seconds: 4));

  await tester.enterText(findNameTextField(), "Tester");
  await tester.tap(find.text("SUBMIT"));
  await tester.pumpAndSettle();
  await tester.tap(find.text("BACK"));
  await tester.pumpAndSettle();

  //Wrong email
  await tester.tap(signupBtn);
  await tester.pumpAndSettle();

  await tester.enterText(email, "");
  await tester.enterText(email, "2355285@gmail.com");
  await tester.enterText(password, "");
  await tester.enterText(password, "23552855");
  await tester.enterText(confirmPassword, "");
  await tester.enterText(confirmPassword, "23552855");
  await tester.tap(signupBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await tester.enterText(findNameTextField(), "Tester");
  await tester.tap(find.text("SUBMIT"));
  await tester.pumpAndSettle();
  await tester.tap(find.text("BACK"));
  await tester.pumpAndSettle();

  //Good

  await tester.tap(signupBtn);
  await tester.pumpAndSettle();

  await tester.enterText(email, "");
  await tester.enterText(email, "2355285@wits.ac.za");
  await tester.enterText(password, "");
  await tester.enterText(password, "2355285");
  await tester.enterText(confirmPassword, "");
  await tester.enterText(confirmPassword, "2355285");
  await tester.tap(signupBtn);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();

}

Future<void> _staffRecoverTest(WidgetTester tester) async {
  await tester.pumpWidget(HookBuilder(builder: (context) {

    return const MaterialApp(home: StaffLoginScreen());
  }));
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 3));


  final btn = find.text("Forgot Password?");
  expect(btn,findsWidgets);
  await tester.tap(btn);
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 2));

  await tester.enterText(findNameTextField(), "a2355285@wits.ac.za");
  // FocusManager.instance.primaryFocus?.unfocus();
  final recoverBtn = find.text("RECOVER");
  expect(recoverBtn,findsWidgets);
  await tester.tap(recoverBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  await tester.pump();

}
