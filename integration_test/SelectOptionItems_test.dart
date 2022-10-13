// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:sdp_wits_services/StaffApp/Dining/Package.dart';
// import 'package:sdp_wits_services/StaffApp/Dining/SelectOptionItems.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:sdp_wits_services/StaffApp/DiningGlobals.dart' as globals;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   group("end-to-end dashboard test", () {
//     testWidgets("selectWidget", _selectItems);
//   });
// }
//
// Future<void> _selectItems(WidgetTester tester) async {
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
//   Package package = Package(
//       packageName: "Option A",
//       items: [
//         "Cheerios",
//         "Corn Flakes",
//         "Coco Pops",
//         "Oats",
//         "ProNutro",
//         "All-Bran Flakes"
//       ],
//       id: "opA");
//
//   await globals.getMenus();
//
//
//   await tester.pumpWidget(MaterialApp(
//     home: SelectOptionItems(
//       package: package,
//       type: "breakfast",
//     ),
//   ));
//
//   await tester.pumpAndSettle();
//
//   await tester.pumpAndSettle();
//   final findTitle = find.text('Select Items');
//   final findItem = find.text("Oats");
//
//   expect(findTitle, findsOneWidget);
//   expect(findItem, findsOneWidget);
//
//   await tester.pump(const Duration(seconds: 0));
//   preferences.clear();
// }
