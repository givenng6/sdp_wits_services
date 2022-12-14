import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/Buses.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/protection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/main.dart' as app;
import 'package:http/http.dart' as http;
import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end app test", () {
    // staff and students app tests
    testWidgets("Stuff app", _staffTest);
    testWidgets("students app", _studentsAppTest);

    // Signup and recover
    testWidgets("signIn as student", _signInAsStudentTests);
    testWidgets("signIn as staff", _signInAsStaffTests);
    testWidgets("_recover email student", _recoverStudentTests);
    testWidgets("_recover email staff", _recoverStaffTests);
  });
}

// Signup as a student tests
Future<void> _signInAsStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));

  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.tap(find.text('SIGNUP'), warnIfMissed: false);
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), '2375736@students.wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findConfirmPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.tap(find.text('SIGNUP'), warnIfMissed: false);
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findNthField(0), 'Nathi');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SUBMIT'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// student recover password tests
Future<void> _recoverStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();

  await tester.enterText(findNameTextField(), '23123456@students.wits.ac.za');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Forgot Password?'), warnIfMissed: false);
  await tester.pumpAndSettle();


  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('RECOVER'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// signup as a staff member tests
Future<void> _signInAsStaffTests(WidgetTester tester)async{
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStaff = find.text('Continue as Staff');

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.tap(find.text('SIGNUP'), warnIfMissed: false);
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.enterText(findNameTextField(), 'a2375736@wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findConfirmPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.tap(find.text('SIGNUP'), warnIfMissed: false);
  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findNthField(0), 'Nathi');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SUBMIT'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// staff recover password tests
Future<void> _recoverStaffTests(WidgetTester tester)async{
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStaff = find.text('Continue as Staff');

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();

  await tester.enterText(findNameTextField(), 'a23123456@wits.ac.za');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Forgot Password?'), warnIfMissed: false);
  await tester.pumpAndSettle();


  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('RECOVER'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await preferences.clear();
}

// Student App tests
Future<void> _studentsAppTest(WidgetTester tester) async {
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  FlutterError.onError = null;
  disableOverflowErrors();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 10));
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await _login(tester);
  await _dashboard(tester);
  await _buses(tester);
  await _diningHall(tester);
  await _protection(tester);
  await _events(tester);
  await _ccdu(tester);
  await _campusHealth(tester);
  await _profile(tester);
  await tester.pump(const Duration(seconds: 10));
  await preferences.clear();
}

// login as a student tests
Future<void> _login(WidgetTester tester) async{
  final continueAsStudentButton = find.byKey(const Key('Continue as Student'));
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.enterText(findNameTextField(), '2375736@students.wits.ac.za');
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('LOGIN'), warnIfMissed: false);
  await tester.pumpAndSettle();
}

// dashborad tests
Future<void> _dashboard(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.fling(find.text('Dining Menu'), const Offset(0.0, 300.0), 1000.0);
  await tester.pump();

  await tester
      .pump(const Duration(seconds: 1)); // finish the scroll animation
  await tester.pump(
      const Duration(seconds: 1)); // finish the indicator settle animation
  await tester.pump(
      const Duration(seconds: 1)); // finish the indicator hide animation
}

// buses tests
Future<void> _buses(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Buses'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('follow0')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('follow1')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(find.byKey(const Key('follow3')), 10.0);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('follow3')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('status3')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byType(Buses), warnIfMissed: false);
  await tester.pumpAndSettle();
}

// dining hall tests
Future<void> _diningHall(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Dining Hall'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('follow0')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('follow1')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('card0')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byType(Icon), warnIfMissed: false);
  await tester.pumpAndSettle();
}

// campus control tests
Future<void> _protection(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Protection'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Book Ride'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('From'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Main Campus').last, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('To'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Student digz').last, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.tap(find.text('Book').last, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.tap(find.text('Cancel Ride').last, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.tap(find.text('Go Back').last, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.tap(find.text('Cancel Ride').last, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.tap(find.text('Cancel Ride').last, warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byType(Protection), warnIfMissed: false);
  await tester.pumpAndSettle();
}

// events tests
Future<void> _events(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Menu'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Events'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.scrollUntilVisible(find.byKey(const Key('like0')), 10.0).then((_) async{
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key('like0')), warnIfMissed: false);
    await tester.pumpAndSettle();
  });
  await tester.scrollUntilVisible(find.byKey(const Key('image1')), 10.0).then((value) async {
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key('image1')), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.close), warnIfMissed: false);
    await tester.pumpAndSettle();
  });
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.arrow_back), warnIfMissed: false);
  await tester.pumpAndSettle();
}

// ccdu tests
Future<void> _ccdu(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  // await tester.tap(find.text('Menu'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Counselling Careers Development Unit'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('New Session'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Submit'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.arrow_back), warnIfMissed: false);
  await tester.pumpAndSettle();
}

// campus health tests
Future<void> _campusHealth(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Campus Health'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.arrow_back), warnIfMissed: false);
  await tester.pumpAndSettle();
}

// profile tests
Future<void> _profile(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('G'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(CupertinoIcons.moon_stars), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.logout_rounded), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Cancel'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('unsubscribe0')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.logout_rounded), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.logout_rounded), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Sign Out'), warnIfMissed: false);
  await tester.pumpAndSettle();
}

// Stuff App
Future<void> _staffTest(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
  FlutterError.onError = null;
  disableOverflowErrors();
  await login("a2355285@wits.ac.za", "2355285", tester);
  //CCDU
  String url = "https://sdpwitsservices-production.up.railway.app";
  await http.get(Uri.parse("$url/ccdu/TestSetup/Init"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });

  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("CCDU")));
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  final profile = find.text("S");
  final allTab = find.text("All");
  final acceptedTab = find.text("Accepted");

  await tester.tap(allTab);
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();

  //All card
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("test1btn")));
  await tester.pump(const Duration(seconds: 2));

  final submitBtn = find.text("Submit");

  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key("linkTextField")), "Some link");
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.tap(submitBtn);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();

  await tester.tap(find.text("Close"));
  await tester.pump(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  await tester.tap(acceptedTab);
  await tester.pump(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  http.get(Uri.parse("$url/ccdu/TestSetup/Cleanup"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8"
  });
  await logout(profile, tester);
  await removeDep(url);
  // Dining
  await login("a2355285@wits.ac.za", "2355285", tester);
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.fastfood));
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Convocation"));
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("breakfastTab")));
  await tester.pumpAndSettle();
  // awaFuture.delayed(const Duration(seconds: 5));
  //breakfast
  await tester.tap(find.byKey(const Key("Option A breakfast Edit")));
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Corn Flakes"));
  await tester.pump(const Duration(seconds: 3));
  await tester.tap(find.byIcon(Icons.check));
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
  //lunch
  await tester.tap(find.byKey(const Key("lunchTab")));
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("Option A lunch Edit")));
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Pizza"));
  await tester.pump(const Duration(seconds: 2));
  await tester.tap(find.byIcon(Icons.check));
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
  //dinner
  await tester.tap(find.byKey(const Key('dinnerTab')));
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("Option A dinner Edit")));
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Ham"));
  await tester.pump(const Duration(seconds: 2));
  await tester.tap(find.byIcon(Icons.check));
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
  await logout(profile, tester);


  //Buses
  await tester.pumpAndSettle();
  await login("a2375736@wits.ac.za", "2375736", tester);
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.bus_alert));
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text("Route 1 - Full Circuit"), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text("Start Shift"), warnIfMissed: false);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text("End Shift"), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  await logout(find.text("N"), tester);
  //Campus Control
  await login("a2355285@wits.ac.za", "2355285", tester);
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.security));
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  await http.get(Uri.parse("$url/tempRoutes/AddStudents"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8"
      });
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("KSD 731 GP")));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  final floatingActionBtn = find.byIcon(Icons.send);
  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final findCampusName = find.text("Business School");
  await tester.tap(find.text("Health Campus"));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(findCampusName);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle();
  // await localGlobals.GetStudents();
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key("student1@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("student2@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("student3@abc.com")));
  await tester.pumpAndSettle(const Duration(seconds: 1));
  final findStart = find.byKey(const Key("start"));
  await tester.tap(findStart);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final findStudentDigz = find.text("Student Digz");
  final findJOne = find.text("J-One");
  await tester.tap(findStudentDigz);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(findJOne);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(floatingActionBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  //End Shift
  final findEndShiftBtn = find.byIcon(Icons.exit_to_app);
  //Open bottom sheet
  await tester.tap(findEndShiftBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  final endShiftBtn = find.text("End Shift");
  await tester.tap(endShiftBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  http.get(Uri.parse("$url/tempRoutes/RemoveStudents"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  });
  await tester.pumpAndSettle();
  await tester.tap(find.text("S"));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  // Events
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Events"));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("like0")));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key("like0")));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Add Event"));
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key("titleTextField")), "Test Title");
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key("venueTextField")), "Test Venue");
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Event Type"),warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Event Type"),warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Event Date"));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("OK"));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("Event Time"));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text("OK"));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
  await tester.tap(find.text("Post"));
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 2));
}

// staff logout tests
Future<void> logout(accountIcon, tester) async {
  await tester.tap(accountIcon);
  await tester.pump(const Duration(seconds: 2));
  await tester.tap(find.byKey(const Key("Logout")));
  await tester.pump(const Duration(seconds: 2));
  await tester.tap(find.text("Sign Out"));
  await tester.pump(const Duration(seconds: 2));
}

// staff login tests
Future<void> login(String email, String password, tester) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 10));
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final continueAsStaff = find.text('Continue as Staff');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(continueAsStaff, warnIfMissed: false);
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), email);
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), password);
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('LOGIN'), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 5));
}

// remove department test
Future<void> removeDep(String url)async{
  await http.post(Uri.parse("$url/tempRoutes/RemoveDep"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email": "a2355285@wits.ac.za"
      }));
}

// disable overflow errors
void disableOverflowErrors() {
  FlutterError.onError = (FlutterErrorDetails details) {
    final exception = details.exception;
    final isOverflowError = exception is FlutterError &&
        !exception.diagnostics.any(
                (e) => e.value.toString().startsWith("A RenderFlex overflowed by"));

    if (isOverflowError) {
      debugPrint("A RenderFlex overflowed by");
    } else {
      FlutterError.presentError(details);
    }
  };
}