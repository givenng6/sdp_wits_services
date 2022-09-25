import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/Dining.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end students dining test", () {
    testWidgets("Students Dining", _diningTests);
  });
}
String uri = "https://web-production-8fed.up.railway.app/";
Future<void> _diningTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  const menu = 'Menu';
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
    return MaterialApp(home: Dining(email, subs, diningHalls, dhFollowing));
  }));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findDiningServicesText = find.text('Dining Services');
  final findUserInitial = find.text(username[0]);
  final findIcon = find.byType(Icon);
  final findMenuText = find.text(menu);
  expect(findDiningServicesText, findsOneWidget);
  // expect(findUserInitial, findsOneWidget);
  // expect(findIcon, findsWidgets);
  // expect(findMenuText, findsOneWidget);
  //
  // expect(find.text('Buses'), findsOneWidget);
  // expect(find.text('Dining Services'), findsOneWidget);
  // expect(find.text('Protection'), findsOneWidget);
  // expect(find.text('Campus Health'), findsOneWidget);
  // expect(find.text('CCDU'), findsOneWidget);
  // expect(find.text('Events'), findsOneWidget);

  // expect(find.text('version 1.0.2 (sprint2)'), findsOneWidget);

  // await tester.pump(const Duration(seconds: 10));
  preferences.clear();
}