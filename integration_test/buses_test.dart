import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StaffApp/Buses/buses_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/Buses.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end buses test", () {
    testWidgets('unsubscribed student buses main', _unSubbedBusesTests);
    testWidgets('staff buses main', _busesTests);
  });
}

String uri = "https://web-production-8fed.up.railway.app/";

Future<void> _unSubbedBusesTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = '2375736@students.wits.ac.za';
  var subs = ['Bus Services', 'Campus Control'];

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

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return MaterialApp(home: Buses(email, subs, const [], const []));
  }));

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  expect(find.text('Bus Services'), findsOneWidget);
  expect(find.text('To access this service you must be subscribed'), findsWidgets);
  expect(find.text('Subscribe'), findsOneWidget);

  await tester.pump(const Duration(seconds: 3));
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
  expect(findBusText, findsOneWidget);
  expect(circleAvatar, findsOneWidget);
  expect(findIcon, findsOneWidget);

  // await tester.pumpAndSettle();
//   await tester.pumpAndSettle(const Duration(seconds: 15));
//   expect(findUserInitial, findsOneWidget);
//   expect(findRoute1, findsOneWidget);
//   expect(findRoute2, findsOneWidget);
//   expect(findRoute3A, findsOneWidget);
//   expect(findRoute3B, findsOneWidget);
//   expect(findRoute3C, findsOneWidget);
//   expect(findRoute4A, findsOneWidget);

//   await tester.tap(findRoute1);
//   await tester.pumpAndSettle(const Duration(seconds: 5));
//   expect(findFloatingActionButton, findsOneWidget);
//   expect(findStartShiftText, findsOneWidget);
//   await tester.pumpAndSettle(const Duration(seconds: 5));

//   await tester.tap(findFloatingActionButton);
//   await tester.pumpAndSettle(const Duration(seconds: 5));
//   expect(findEndShiftText, findsOneWidget);
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
