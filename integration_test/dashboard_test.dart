import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusObject.dart';
import 'package:sdp_wits_services/StudentsApp/Dashboard/Dashboard.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end dashboard test", () {
    testWidgets("dashboard", _dashboardTests);
    testWidgets("dining breakfast", _diningBreakfastTests);
    testWidgets("dining lunch", _diningLunchTests);
    // testWidgets("dining lunch", _diningLunchTests);
  });
}

String uri = "https://web-production-8fed.up.railway.app/";

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
  expect(findDiningServicesText, findsOneWidget);
  expect(findCampusHealthText, findsOneWidget);
  expect(findEventsText, findsOneWidget);
  expect(findCCDUText, findsOneWidget);
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
  expect(findDiningServicesText, findsOneWidget);
  expect(findCampusHealthText, findsOneWidget);
  expect(findEventsText, findsOneWidget);
  expect(findCCDUText, findsOneWidget);
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
  expect(findDiningMenuText, findsOneWidget);
  expect(findHighfieldText, findsOneWidget);
  expect(findMealText, findsOneWidget);
  expect(findTimeText, findsOneWidget);
  expect(findOption1Text, findsOneWidget);
  expect(findOption2Text, findsOneWidget);
  expect(findOption3Text, findsOneWidget);
  expect(find.text('Mango'), findsOneWidget);

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