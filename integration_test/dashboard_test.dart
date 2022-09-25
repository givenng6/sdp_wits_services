import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StudentsApp/Dashboard/Dashboard.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end dashboard test", () {
    testWidgets("dashboard", _diningTests);
  });
}
String uri = "https://web-production-8fed.up.railway.app/";
Future<void> _diningTests(WidgetTester tester)async{
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
    return MaterialApp(home: Dashboard(false, subs, const [], const [], diningHalls, dhFollowing, 'dinner'));
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
  final findMealText = find.text('Meal: dinner');
  final findTimeText = find.text('Time: 16:00 - 19:00');
  final findOption1Text = find.text('Option 1');
  final findOption2Text = find.text('Option 2');
  final findOption3Text = find.text('Option 3');
  // final findIcon = find.byType(Icon);
  expect(findDiningMenuText, findsOneWidget);
  expect(findHighfieldText, findsOneWidget);
  expect(findMealText, findsOneWidget);
  expect(findTimeText, findsOneWidget);
  expect(findOption1Text, findsOneWidget);
  expect(findOption2Text, findsOneWidget);
  expect(findOption3Text, findsOneWidget);
  // expect(findIcon, findsWidgets);



  await tester.pump(const Duration(seconds: 300));
  preferences.clear();
}