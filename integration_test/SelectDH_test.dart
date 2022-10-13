// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:sdp_wits_services/StaffApp/Dining/SelectOptionItems.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:sdp_wits_services/StaffApp/SelectDH.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   group("end-to-end dashboard test", () {
//     testWidgets("selectWidget", _selectDHtest);
//   });
// }
//
// Future<void> _selectDHtest(WidgetTester tester)async{
//   const username = 'Sabelo Mabena';
//   const email = 'a2355285@wits.ac.za';
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.setString('username', username);
//   preferences.setString('email', email);
//   preferences.setString('dhName', 'Convocation');
//   await tester.pumpAndSettle();
//   await tester.pump(const Duration(seconds: 1));
//
//   await tester.pumpWidget(HookBuilder(builder: (context) {
//
//     return const MaterialApp(home: SelectDH());
//   }));
//
//   await tester.pumpAndSettle();
//
//   await tester.pumpAndSettle();
//   final findCardItem = find.text('Main');
//   final findSelectDH = find.text("Dining Hall");
//   final findUserName = find.text("S");
//   final findIcon = find.byIcon(Icons.fastfood);
//
//   expect(findCardItem, findsOneWidget);
//   expect(findSelectDH, findsOneWidget);
//   expect(findUserName, findsOneWidget);
//   expect(findIcon, findsOneWidget);
//
//   await tester.pump(const Duration(seconds: 0));
//   preferences.clear();
// }