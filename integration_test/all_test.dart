import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StaffApp/Buses/buses_main.dart';
import 'package:sdp_wits_services/StaffApp/Dining/Package.dart';
import 'package:sdp_wits_services/StaffApp/Dining/SelectOptionItems.dart';
import 'package:sdp_wits_services/StaffApp/Dining/mealSelectionPage.dart';
import 'package:sdp_wits_services/StaffApp/SelectDH.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusObject.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/Buses.dart';
import 'package:sdp_wits_services/StudentsApp/Dashboard/Dashboard.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/Dining.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/ViewDH.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/main.dart' as app;
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart' as staff;
import 'package:sdp_wits_services/StudentsApp/Profile/Profile.dart' as students;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sdp_wits_services/StaffApp/DiningGlobals.dart' as globals;

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end app test", () {
    // App
    testWidgets("continue as student", _continueAsStudentTests);
    testWidgets("continue as staff", _continueAsStaffTests);

    // Buses
    testWidgets('unsubscribed student buses main', _unSubbedBusesTests);
    testWidgets('subscribed student buses main', _subbedBusesTests);
    testWidgets('staff buses main', _busesTests);

    // Dashboard
    testWidgets("dashboard", _dashboardTests);
    testWidgets("dining breakfast", _diningBreakfastTests);
    testWidgets("dining lunch", _diningLunchTests);

    // Dining
    testWidgets("Staff Dining", _staffDiningTests);
    testWidgets("Student Dining", _studentDiningTests);

    // Profile
    testWidgets("Students Profile", _studentsProfileTests);
    testWidgets("Staff Profile", _staffProfileTests);

    // Staff Dining
    testWidgets("selectWidget", _selectDHtest);
    testWidgets("selectWidget", _selectItems);

    // Students Dining
    testWidgets("Unsubscribed Students Dining", _unSubbedDiningTests);
    testWidgets("Subscribed Students Dining", _subbedDiningTests);
    testWidgets("Main Dining", _mainDiningTests);
  });
}

// App

Future<void> _continueAsStudentTests(WidgetTester tester)async{
  final continueAsStudentButton =
  find.byKey(const Key('Continue as Student'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  final continueAsStudent = find.text('Continue as Student');
  expect(continueAsStudent, findsWidgets);
  final continueAsStaff = find.text('Continue as Staff');
  expect(continueAsStaff, findsWidgets);

  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(continueAsStudentButton);
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final witsServices = find.text('Wits Services');
  expect(witsServices, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'));
  await tester.pumpAndSettle();
  final confirmPassword = find.text('Confirm Password');
  expect(confirmPassword, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('Forgot Password?'));
  await tester.pumpAndSettle();
  final resetYourPasswordHere = find.text('Reset your password here');
  expect(resetYourPasswordHere, findsWidgets);
  final weWillSendALinkToTheEmailAccount =
  find.text('We will send a link to the email account.');
  expect(weWillSendALinkToTheEmailAccount, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('RECOVER'));
  await tester.pumpAndSettle();
  final invalidEmail = find.text('Invalid email!');
  expect(invalidEmail, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('BACK'));
  await tester.pumpAndSettle();
  final email = find.text('Email');
  expect(email, findsWidgets);
  final password = find.text('Password');
  expect(password, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'));
  await tester.pumpAndSettle();
  expect(invalidEmail, findsWidgets);
  await Future.delayed(const Duration(seconds: 1));
  final passwordIsTooShort = find.text('Password is too short!');
  expect(passwordIsTooShort, findsWidgets);
  // await tester.tap(find.text('LOGIN'));
  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), '23123456@students.wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '1234567890');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findConfirmPasswordTextField(), '1234567890');
  await tester.pumpAndSettle();
  // FocusScope.of(context).unfocus();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'));
  await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 3));
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final enterUsernameToCompleteSignup = find.text('Enter your username in this form to complete signup');
  await tester.tap(find.text('SUBMIT'));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  expect(enterUsernameToCompleteSignup, findsWidgets);
  final username = find.text('Username');
  expect(username, findsWidgets);
  final usernameIsRequired = find.text('Username is required!');
  expect(usernameIsRequired, findsWidgets);
  final submit = find.text('SUBMIT');
  expect(submit, findsWidgets);
  final back = find.text('BACK');
  expect(back, findsWidgets);
  await tester.enterText(findNthField(0), 'Nathi');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('BACK'));
  await tester.pumpAndSettle();
  expect(find.text('Email'), findsWidgets);
}

Future<void> _continueAsStaffTests(WidgetTester tester) async{
  final continueAsStaffButton = find.byKey(const Key('Continue as Staff'));
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 5000));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(continueAsStaffButton);
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final witsServices = find.text('Wits Services');
  expect(witsServices, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'));
  await tester.pumpAndSettle();
  final confirmPassword = find.text('Confirm Password');
  expect(confirmPassword, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('Forgot Password?'));
  await tester.pumpAndSettle();
  final resetYourPasswordHere = find.text('Reset your password here');
  expect(resetYourPasswordHere, findsWidgets);
  final weWillSendALinkToTheEmailAccount =
  find.text('We will send a link to the email account.');
  expect(weWillSendALinkToTheEmailAccount, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('RECOVER'));
  await tester.pumpAndSettle();
  final invalidEmail = find.text('Invalid email!');
  expect(invalidEmail, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('BACK'));
  await tester.pumpAndSettle();
  final email = find.text('Email');
  expect(email, findsWidgets);
  final password = find.text('Password');
  expect(password, findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'));
  await tester.pumpAndSettle();
  expect(invalidEmail, findsWidgets);
  final passwordIsTooShort = find.text('Password is too short!');
  expect(passwordIsTooShort, findsWidgets);

  await tester.pumpAndSettle();
  await tester.enterText(findNameTextField(), 'a23123456@wits.ac.za');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '1234567890');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.enterText(findConfirmPasswordTextField(), '1234567890');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('SIGNUP'))
  ;await tester.pumpAndSettle();

  await Future.delayed(const Duration(seconds: 3));
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  final enterUsernameToCompleteSignup = find.text('Enter your username in this form to complete signup');
  await tester.tap(find.text('SUBMIT'));
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  expect(enterUsernameToCompleteSignup, findsWidgets);
  final username = find.text('Username');
  expect(username, findsWidgets);
  final usernameIsRequired = find.text('Username is required!');
  expect(usernameIsRequired, findsWidgets);
  final submit = find.text('SUBMIT');
  expect(submit, findsWidgets);
  final back = find.text('BACK');
  expect(back, findsWidgets);
  await tester.enterText(findNthField(0), 'Nathi');
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('BACK'));
  await tester.pumpAndSettle();
  expect(find.text('Email'), findsWidgets);

  await Future.delayed(const Duration(seconds: 1));
}

// Buses

String uri = "https://web-production-8fed.up.railway.app/";

Future<void> _unSubbedBusesTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Subscriptions()),
    ChangeNotifierProvider(create: (_) => UserData()),
  ],
    child: const MaterialApp(home: Buses()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  expect(find.text('Bus Services'), findsWidgets);
  expect(find.text('To access this service you must be subscribed'), findsWidgets);
  expect(find.text('Subscribe'), findsWidgets);

  await tester.pump(const Duration(seconds: 3));
  preferences.clear();
}

Future<void> _subbedBusesTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  List<BusObject> busSchedule = [];
  var busFollowing = [];

  await http.get(Uri.parse("${uri}db/getBusSchedule/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    List<BusObject> tempSchedule = [];
    for (var data in toJSON) {
      String pos = "";
      if (data['position'] != null) {
        pos = data['position'];
      }
      tempSchedule.add(BusObject(
          data['name'], data['id'], data['stops'], data['status'], pos));
    }
    busSchedule = tempSchedule;
  });

  await http
      .post(Uri.parse("${uri}db/getBusFollowing/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email": email,
      }))
      .then((value) {
    var busData = jsonDecode(value.body);
    busFollowing = busData;
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Subscriptions()),
    ChangeNotifierProvider(create: (_) => UserData()),
  ],
    child: MaterialApp(home: Buses(isTesting: true, busSchedule: busSchedule,)),
  );

  await tester.pumpWidget(widget);
  await Future.delayed(const Duration(seconds: 5));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  // await Future.delayed(const Duration(seconds: 5));
  expect(find.text('Bus Services'), findsWidgets);
  expect(find.text('Status'), findsWidgets);
  expect(find.text('Follow'), findsWidgets);
  expect(find.text('Route 1 - Full Circuit'), findsWidgets);
  expect(find.text('Yale Village'), findsWidgets);

  await tester.pump(const Duration(seconds: 1));
  preferences.clear();
}

Future<void> _busesTests(WidgetTester tester) async{
  const username = 'Nkosinathi Chuma';
  const email = 'a2375736@wits.ac.za';
  const onShift = false;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setBool('onShift', onShift);
  await tester.pump();

  Widget widget = const MaterialApp(
    home: BusesMain(),
  );
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  final findBusText = find.text('Buses');
  // final findRoute1 = find.text('Route 1 - Full Circuit');
  // final findRoute2 = find.text('Route 2 - WEC | REN');
  // final findRoute3A = find.text('Route 3A - WJ | AMIC');
  // final findRoute3B = find.text('Route 3B - WJ | WEC');
  // final findRoute3C = find.text('Route 3C WJ | WEC | AMIC');
  // final findRoute4A = find.text('Route 4A - WEC | AMIC');
  // final findFloatingActionButton = find.byType(FloatingActionButton);
  // final findStartShiftText = find.text('Start Shift');
  // final findEndShiftText = find.text('End Shift');
  // final findUserInitial = find.text('N');
  final circleAvatar = find.byType(CircleAvatar);
  final findIcon = find.byType(Icon);
  expect(findBusText, findsWidgets);
  expect(circleAvatar, findsWidgets);
  expect(findIcon, findsWidgets);

  // await tester.pumpAndSettle();
//   await tester.pumpAndSettle(const Duration(seconds: 15));
//   expect(findUserInitial, findsWidgets);
//   expect(findRoute1, findsWidgets);
//   expect(findRoute2, findsWidgets);
//   expect(findRoute3A, findsWidgets);
//   expect(findRoute3B, findsWidgets);
//   expect(findRoute3C, findsWidgets);
//   expect(findRoute4A, findsWidgets);

//   await tester.tap(findRoute1);
//   await tester.pumpAndSettle(const Duration(seconds: 5));
//   expect(findFloatingActionButton, findsWidgets);
//   expect(findStartShiftText, findsWidgets);
//   await tester.pumpAndSettle(const Duration(seconds: 5));

//   await tester.tap(findFloatingActionButton);
//   await tester.pumpAndSettle(const Duration(seconds: 5));
//   expect(findEndShiftText, findsWidgets);
//   await tester.pumpAndSettle(const Duration(seconds: 5));

//   await tester.tap(findFloatingActionButton);
//   await tester.pumpAndSettle(const Duration(seconds: 5));
//   await tester.tap(findRoute1);
//   await tester.pumpAndSettle(const Duration(seconds: 5));
//   expect(findEndShiftText, findsNothing);
//   expect(findFloatingActionButton, findsNothing);
//   expect(findStartShiftText, findsNothing);
//   await tester.pumpAndSettle(const Duration(seconds: 5));

  preferences.clear();
}

// Dashboard

Future<void> _dashboardTests(WidgetTester tester) async {
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  List<DiningObject> diningHalls = [];
  var dhFollowing = 'DH4';

  await http
      .get(Uri.parse("${uri}db/getDiningHalls/"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  List<BusObject> busSchedule = [];
  List<String> busFollowing = [];

  await http
      .get(Uri.parse("${uri}db/getBusSchedule/"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  }).then((response) {
    var toJSON = jsonDecode(response.body);
    List<BusObject> tempSchedule = [];
    for (var data in toJSON) {
      String pos = "";
      if (data['position'] != null) {
        pos = data['position'];
      }
      tempSchedule.add(BusObject(
          data['name'], data['id'], data['stops'], data['status'], pos));
    }
    busSchedule = tempSchedule;
  });

  await http
      .post(Uri.parse("${uri}db/getBusFollowing/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email": email,
      }))
      .then((value) {
    var busData = jsonDecode(value.body);
    busFollowing = List<String>.from(busData);
  });

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MaterialApp(
        home: Dashboard(
          isTesting: true,
          busSchedule: busSchedule,
          busFollowing: busFollowing,
          dhFollowing: dhFollowing,
          diningHalls: diningHalls,
          mealTime: 'Dinner',
        )),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findDiningServicesText = find.text('Suggestions:');
  final findCampusHealthText = find.text('Campus Health');
  final findEventsText = find.text('Events');
  final findCCDUText = find.text('CCDU');
  final findIcon = find.byType(Icon);
  expect(findDiningServicesText, findsWidgets);
  expect(findCampusHealthText, findsWidgets);
  expect(findEventsText, findsWidgets);
  expect(findCCDUText, findsWidgets);
  expect(findIcon, findsWidgets);

  // Dining Widget
  await tester.pumpAndSettle();
  final findDiningMenuText = find.text('Dining Menu');
  final findHighfieldText = find.text('Highfield');
  final findMealText = find.text('Meal: Dinner');
  final findTimeText = find.text('Time: 16:00 - 19:00');
  final findOption1Text = find.text('Option 1');
  final findOption2Text = find.text('Option 2');
  final findOption3Text = find.text('Option 3');

  await tester.pump(const Duration(seconds: 10));

  expect(find.text('Cake'), findsWidgets);
  expect(findDiningMenuText, findsWidgets);
  expect(findHighfieldText, findsWidgets);
  expect(findMealText, findsWidgets);
  expect(findTimeText, findsWidgets);
  expect(findOption1Text, findsWidgets);
  expect(findOption2Text, findsWidgets);
  expect(findOption3Text, findsWidgets);

  // Buses Widget
  expect(find.text('Bus Services'), findsWidgets);
  expect(find.text('Route 3B - WJ | WEC'), findsWidgets);
  expect(find.text('Status: OFF'), findsWidgets);
  expect(find.text(""), findsWidgets);
  expect(find.byKey(const Key('HomeIcon')), findsNothing);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}

Future<void> _diningBreakfastTests(WidgetTester tester) async {
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  List<DiningObject> diningHalls = [];
  var dhFollowing = 'DH4';

  await http
      .get(Uri.parse("${uri}db/getDiningHalls/"), headers: <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MaterialApp(
        home: Dashboard(
          isTesting: true,
          busSchedule: const [],
          busFollowing: const [],
          dhFollowing: dhFollowing,
          diningHalls: diningHalls,
          mealTime: 'Breakfast',
        )),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findDiningServicesText = find.text('Suggestions:');
  final findCampusHealthText = find.text('Campus Health');
  final findEventsText = find.text('Events');
  final findCCDUText = find.text('CCDU');
  final findIcon = find.byType(Icon);
  expect(findDiningServicesText, findsWidgets);
  expect(findCampusHealthText, findsWidgets);
  expect(findEventsText, findsWidgets);
  expect(findCCDUText, findsWidgets);
  expect(findIcon, findsWidgets);

  await tester.pumpAndSettle();
  final findDiningMenuText = find.text('Dining Menu');
  final findHighfieldText = find.text('Highfield');
  final findMealText = find.text('Meal: Breakfast');
  final findTimeText = find.text('Time: 06:00 - 09:00');
  final findOption1Text = find.text('Option 1');
  final findOption2Text = find.text('Option 2');
  final findOption3Text = find.text('Option 3');

  await tester.pump(const Duration(seconds: 10));
  expect(findDiningMenuText, findsWidgets);
  expect(findHighfieldText, findsWidgets);
  expect(findMealText, findsWidgets);
  expect(findTimeText, findsWidgets);
  expect(findOption1Text, findsWidgets);
  expect(findOption2Text, findsWidgets);
  expect(findOption3Text, findsWidgets);
  expect(find.text('Mango'), findsWidgets);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}

Future<void> _diningLunchTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  List<DiningObject> diningHalls = [];
  var dhFollowing = 'DH4';

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MaterialApp(
        home: Dashboard(
          isTesting: true,
          busSchedule: const [],
          busFollowing: const [],
          dhFollowing: dhFollowing,
          diningHalls: diningHalls,
          mealTime: 'Lunch',
        )),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findDiningServicesText = find.text('Suggestions:');
  final findCampusHealthText = find.text('Campus Health');
  final findEventsText = find.text('Events');
  final findCCDUText = find.text('CCDU');
  final findIcon = find.byType(Icon);
  expect(findDiningServicesText, findsWidgets);
  expect(findCampusHealthText, findsWidgets);
  expect(findEventsText, findsWidgets);
  expect(findCCDUText, findsWidgets);
  expect(findIcon, findsWidgets);

  await tester.pumpAndSettle();
  final findDiningMenuText = find.text('Dining Menu');
  final findHighfieldText = find.text('Highfield');
  final findMealText = find.text('Meal: Lunch');
  final findTimeText = find.text('Time: 11:00 - 14:00');
  final findOption1Text = find.text('Option 1');
  final findOption2Text = find.text('Option 2');
  final findOption3Text = find.text('Option 3');

  await tester.pump(const Duration(seconds: 10));
  expect(findDiningMenuText, findsWidgets);
  expect(findHighfieldText, findsWidgets);
  expect(findMealText, findsWidgets);
  expect(findTimeText, findsWidgets);
  expect(findOption1Text, findsWidgets);
  expect(findOption2Text, findsWidgets);
  expect(findOption3Text, findsWidgets);
  expect(find.text('Avocado'), findsWidgets);

  await tester.pump(const Duration(seconds: 3));
  preferences.clear();
}

// Dining

Future<void> _studentDiningTests(WidgetTester tester) async{
  const username = 'Lindokuhle Mabena';
  const email = 'a2355285@wits.ac.za';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pump();

  Widget widget = const MaterialApp(
    home: mealSelecionPage(),
  );
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();
}

Future<void> _staffDiningTests(WidgetTester tester) async{
  const username = 'Lindokuhle Mabena';
  const email = 'a2355285@wits.ac.za';
  const dhName = 'Ernest Openheimer';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('dhName', dhName);
  await tester.pump();

  Widget widget = const MaterialApp(
    home: mealSelecionPage(),
  );
  debugPrint('here');
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  final findDHTitle = find.text(dhName);
  final findUserInitial = find.text('L');
  final findBreakfastText = find.text('Breakfast');
  final findLunchText = find.text('Lunch');
  final findDinnerText = find.text('Dinner');
  final findOptionA = find.text('Option A');
  final findOptionB = find.text('Option B');
  final findOptionC = find.text('Option C');
  final findIcon = find.byType(Icon);
  expect(findDHTitle, findsWidgets);
  expect(findUserInitial, findsWidgets);
  expect(findBreakfastText, findsWidgets);
  expect(findLunchText, findsWidgets);
  expect(findDinnerText, findsWidgets);
  expect(findOptionA, findsWidgets);
  expect(findOptionB, findsWidgets);
  expect(findOptionC, findsWidgets);
  expect(findIcon, findsWidgets);
  await tester.tap(findLunchText);
  await tester.pumpAndSettle();

  expect(findOptionA, findsWidgets);
  expect(findOptionB, findsWidgets);
  expect(findOptionC, findsWidgets);

  await tester.tap(findDinnerText);
  await tester.pumpAndSettle();

  expect(findOptionA, findsWidgets);
  expect(findOptionB, findsWidgets);
  expect(findOptionC, findsWidgets);

  preferences.clear();
}

// Profile

Future<void> _studentsProfileTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = 'a2375736@wits.ac.za';
  const subs = <String>['Dining Services', 'Bus Services', 'Campus Control'];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const MaterialApp(
        home: students.Profile(isTesting: true, email: email, username: username, subs: subs,)),
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findUsername = find.text(username);
  final findEmail = find.text(email);
  final findIconButtons = find.byType(IconButton);
  final findIcon = find.byType(Icon);
  final findClipOval = find.byType(ClipOval);
  final findDiningServicesText = find.text(subs[0]);
  final findBusServicesText = find.text(subs[1]);
  final findProtectionServicesText = find.text(subs[2]);
  final findSubscriptionsText = find.text('Subscriptions');

  await tester.pump(const Duration(seconds: 5));
  expect(findUsername, findsWidgets);
  expect(findEmail, findsWidgets);
  expect(findIcon, findsWidgets);
  expect(findIconButtons, findsWidgets);
  expect(findClipOval, findsWidgets);
  expect(findDiningServicesText, findsWidgets);
  expect(findBusServicesText, findsWidgets);
  expect(findProtectionServicesText, findsWidgets);
  expect(findSubscriptionsText, findsWidgets);

  await tester.tap(find.byKey(const Key('Logout')));
  await tester.pumpAndSettle();
  expect(find.text('Are you sure you want to Sign Out?'), findsWidgets);
  expect(find.text('Sign Out'), findsWidgets);
  expect(find.text('Cancel'), findsWidgets);

  await tester.pump(const Duration(seconds: 3));
  preferences.clear();
}

Future<void> _staffProfileTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = 'a2375736@wits.ac.za';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MaterialApp(
    home: staff.Profile(email, username),
  );
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findUsername = find.text(username);
  final findEmail = find.text(email);
  final findIconButtons = find.byType(IconButton);
  final findIcon = find.byType(Icon);
  final findClipOval = find.byType(ClipOval);
  expect(findUsername, findsWidgets);
  expect(findEmail, findsWidgets);
  expect(findIcon, findsWidgets);
  expect(findIconButtons, findsWidgets);
  expect(findClipOval, findsWidgets);

  await tester.tap(find.byKey(const Key('Logout')));
  await tester.pumpAndSettle();
  expect(find.text('Are you sure you want to Sign Out?'), findsWidgets);
  expect(find.text('Sign Out'), findsWidgets);
  expect(find.text('Cancel'), findsWidgets);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}

// Staff Dining

Future<void> _selectDHtest(WidgetTester tester)async{
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('dhName', 'Convocation');
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  await tester.pumpWidget(HookBuilder(builder: (context) {

    return const MaterialApp(home: SelectDH());
  }));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findCardItem = find.text('Main');
  final findSelectDH = find.text("Dining Hall");
  final findUserName = find.text("S");
  final findIcon = find.byIcon(Icons.fastfood);

  expect(findCardItem, findsWidgets);
  expect(findSelectDH, findsWidgets);
  expect(findUserName, findsWidgets);
  expect(findIcon, findsWidgets);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}

Future<void> _selectItems(WidgetTester tester) async {
  const username = 'Sabelo Mabena';
  const email = 'a2355285@wits.ac.za';

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  preferences.setString('dhName', 'Convocation');
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Package package = Package(
      packageName: "Option A",
      items: [
        "Cheerios",
        "Corn Flakes",
        "Coco Pops",
        "Oats",
        "ProNutro",
        "All-Bran Flakes"
      ],
      id: "opA");

  await globals.getMenus();


  await tester.pumpWidget(MaterialApp(
    home: SelectOptionItems(
      package: package,
      type: "breakfast",
    ),
  ));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findTitle = find.text('Select Items');
  final findItem = find.text("Oats");

  expect(findTitle, findsWidgets);
  expect(findItem, findsWidgets);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}

// Students Dining

Future<void> _unSubbedDiningTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var diningHalls = [];

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const MaterialApp(
        home: Dining()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  expect(find.text('Dining Services'), findsWidgets);
  expect(find.text('To access this service you must be subscribed'), findsWidgets);
  expect(find.text('Subscribe'), findsWidgets);

  await tester.pump(const Duration(seconds: 3));
  preferences.clear();
}

Future<void> _subbedDiningTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var diningHalls = <DiningObject>[];

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MaterialApp(
        home: Dining(isTesting: true, email: email, diningHalls: diningHalls,)),
  );

  await tester.pumpWidget(widget);
  await tester.pump(const Duration(seconds: 3));

  await tester.pumpAndSettle();
  expect(find.text('Dining Services'), findsWidgets);
  expect(find.text('Follow'), findsWidgets);
  expect(find.text('Following'), findsWidgets);
  expect(find.text('Main'), findsWidgets);
  expect(find.text('Jubilee'), findsWidgets);
  expect(find.text('Convocation'), findsWidgets);
  expect(find.text('Highfield'), findsWidgets);
  expect(find.text('Ernest Openheimer'), findsWidgets);
  expect(find.text('Knockando'), findsWidgets);
  expect(find.text('A44 Wits East Campus'), findsWidgets);

  await tester.pump(const Duration(seconds: 3));
  preferences.clear();
}

Future<void> _mainDiningTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var diningHalls = [];

  await http.get(Uri.parse("${uri}db/getDiningHalls/"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      }).then((response) {
    var toJSON = jsonDecode(response.body);
    for (var data in toJSON) {
      diningHalls.add(DiningObject(
          data['name'],
          data['id'],
          data['breakfast']['optionA'],
          data['breakfast']['optionB'],
          data['breakfast']['optionC'],
          data['lunch']['optionA'],
          data['lunch']['optionB'],
          data['lunch']['optionC'],
          data['dinner']['optionA'],
          data['dinner']['optionB'],
          data['dinner']['optionC']));
    }
  });

  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return MaterialApp(home: ViewDH(diningHalls[0]));
  }));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  expect(find.text('Main'), findsWidgets);
  expect(find.text('Breakfast'), findsWidgets);
  expect(find.text('Lunch'), findsWidgets);
  expect(find.text('Dinner'), findsWidgets);
  expect(find.text('Option 1'), findsWidgets);
  expect(find.text('Option 2'), findsWidgets);
  expect(find.text('Option 3'), findsWidgets);

  for(int i = 0; i < diningHalls[0].bfA.length; i++) {
    expect(find.text(diningHalls[0].bfA[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].bfB.length; i++) {
    expect(find.text(diningHalls[0].bfB[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].bfC.length; i++) {
    expect(find.text(diningHalls[0].bfC[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].lA.length; i++) {
    expect(find.text(diningHalls[0].lA[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].lB.length; i++) {
    expect(find.text(diningHalls[0].lB[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].lC.length; i++) {
    expect(find.text(diningHalls[0].lC[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].dA.length; i++) {
    expect(find.text(diningHalls[0].dA[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].dB.length; i++) {
    expect(find.text(diningHalls[0].dB[i]), findsWidgets);
  }
  for(int i = 0; i < diningHalls[0].dC.length; i++) {
    expect(find.text(diningHalls[0].dC[i]), findsWidgets);
  }

  await tester.pump(const Duration(seconds: 10));
  preferences.clear();
}