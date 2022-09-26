import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusObject.dart';
import 'package:sdp_wits_services/StudentsApp/Dashboard/Dashboard.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end dashboard test", () {
    testWidgets("dashboard", _dashboardTests);
    testWidgets("dining breakfast", _diningBreakfastTests);
    // testWidgets("dining lunch", _diningLunchTests);
  });
}
String uri = "https://web-production-8fed.up.railway.app/";
Future<void> _dashboardTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var subs = ['dining_service', 'bus_service', 'Campus Control'];
  var diningHalls = [];
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

  var busSchedule = [];
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

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return MaterialApp(home: Dashboard(false, subs, busSchedule, busFollowing, diningHalls, dhFollowing, 'dinner'));
  }));

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
  final findMealText = find.text('Meal: dinner');
  final findTimeText = find.text('Time: 16:00 - 19:00');
  final findOption1Text = find.text('Option 1');
  final findOption2Text = find.text('Option 2');
  final findOption3Text = find.text('Option 3');
  expect(find.text('Cake'), findsOneWidget);

  expect(findDiningMenuText, findsOneWidget);
  expect(findHighfieldText, findsOneWidget);
  expect(findMealText, findsOneWidget);
  expect(findTimeText, findsOneWidget);
  expect(findOption1Text, findsOneWidget);
  expect(findOption2Text, findsOneWidget);
  expect(findOption3Text, findsOneWidget);

  // Buses Widget
  expect(find.text('Bus Services'), findsOneWidget);
  expect(find.text('Route 3B - WJ | WEC'), findsOneWidget);
  expect(find.text('Status: OFF'), findsOneWidget);
  expect(find.text(""), findsWidgets);
  expect(find.byKey(const Key('HomeIcon')), findsNothing);

  await tester.pump(const Duration(seconds: 0));
  preferences.clear();
}

Future<void> _diningBreakfastTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var subs = ['dining_service', 'Bus Services', 'Campus Control'];
  var diningHalls = [];
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

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return MaterialApp(home: Dashboard(false, subs, const [], const [], diningHalls, dhFollowing, 'Breakfast'));
  }));

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

// Future<void> _diningLunchTests(WidgetTester tester)async{
//   const username = 'Nkosinathi Chuma';
//   const email = '2375736@students.wits.ac.za';
//   var subs = ['dining_service', 'Bus Services', 'Campus Control'];
//   var diningHalls = [];
//   var dhFollowing = 'DH4';
//
//   await http.get(Uri.parse("${uri}db/getDiningHalls/"),
//       headers: <String, String>{
//         "Accept": "application/json",
//         "Content-Type": "application/json; charset=UTF-8",
//       }).then((response) {
//     var toJSON = jsonDecode(response.body);
//     for (var data in toJSON) {
//       diningHalls.add(DiningObject(
//           data['name'],
//           data['id'],
//           data['breakfast']['optionA'],
//           data['breakfast']['optionB'],
//           data['breakfast']['optionC'],
//           data['lunch']['optionA'],
//           data['lunch']['optionB'],
//           data['lunch']['optionC'],
//           data['dinner']['optionA'],
//           data['dinner']['optionB'],
//           data['dinner']['optionC']));
//     }
//   });
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.setString('username', username);
//   preferences.setString('email', email);
//   await tester.pumpAndSettle();
//   await tester.pump(const Duration(seconds: 1));
//
//   await tester.pumpWidget(HookBuilder(builder: (context) {
//     return MaterialApp(home: Dashboard(false, subs, const [], const [], diningHalls, dhFollowing, 'Lunch'));
//   }));
//
//   await tester.pumpAndSettle();
//
//   await tester.pumpAndSettle();
//   final findDiningServicesText = find.text('Suggestions:');
//   final findCampusHealthText = find.text('Campus Health');
//   final findEventsText = find.text('Events');
//   final findCCDUText = find.text('CCDU');
//   final findIcon = find.byType(Icon);
//   expect(findDiningServicesText, findsOneWidget);
//   expect(findCampusHealthText, findsOneWidget);
//   expect(findEventsText, findsOneWidget);
//   expect(findCCDUText, findsOneWidget);
//   expect(findIcon, findsWidgets);
//
//   await tester.pumpAndSettle();
//   final findDiningMenuText = find.text('Dining Menu');
//   final findHighfieldText = find.text('Highfield');
//   final findMealText = find.text('Meal: Lunch');
//   final findTimeText = find.text('Time: 11:00 - 14:00');
//   final findOption1Text = find.text('Option 1');
//   final findOption2Text = find.text('Option 2');
//   final findOption3Text = find.text('Option 3');
//   expect(findDiningMenuText, findsOneWidget);
//   expect(findHighfieldText, findsOneWidget);
//   expect(findMealText, findsOneWidget);
//   expect(findTimeText, findsOneWidget);
//   expect(findOption1Text, findsOneWidget);
//   expect(findOption2Text, findsOneWidget);
//   expect(findOption3Text, findsOneWidget);
//   expect(find.text('Avocado'), findsOneWidget);
//
//   await tester.pump(const Duration(seconds: 0));
//   preferences.clear();
// }

