//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:sdp_wits_services/StaffApp/Dining/mealSelectionPage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   group('description', () {
//     testWidgets("Staff Dining", _staffDiningTests);
//     testWidgets("Student Dining", _studentDiningTests);
//   });
// }
//
// Future<void> _studentDiningTests(WidgetTester tester) async{
//   const username = 'Lindokuhle Mabena';
//   const email = 'a2355285@wits.ac.za';
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.setString('username', username);
//   preferences.setString('email', email);
//   await tester.pump();
//
//   Widget widget = const MaterialApp(
//     home: mealSelecionPage(),
//   );
//   await tester.pumpWidget(widget);
//   await tester.pumpAndSettle();
// }
//
// Future<void> _staffDiningTests(WidgetTester tester) async{
//   const username = 'Lindokuhle Mabena';
//   const email = 'a2355285@wits.ac.za';
//   const dhName = 'Ernest Openheimer';
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.setString('username', username);
//   preferences.setString('email', email);
//   preferences.setString('dhName', dhName);
//   await tester.pump();
//
//   Widget widget = const MaterialApp(
//     home: mealSelecionPage(),
//   );
//   debugPrint('here');
//   await tester.pumpWidget(widget);
//   await tester.pumpAndSettle();
//
//   final findDHTitle = find.text(dhName);
//   final findUserInitial = find.text('L');
//   final findBreakfastText = find.text('Breakfast');
//   final findLunchText = find.text('Lunch');
//   final findDinnerText = find.text('Dinner');
//   final findOptionA = find.text('Option A');
//   final findOptionB = find.text('Option B');
//   final findOptionC = find.text('Option C');
//   final findIcon = find.byType(Icon);
//   expect(findDHTitle, findsOneWidget);
//   expect(findUserInitial, findsOneWidget);
//   expect(findBreakfastText, findsOneWidget);
//   expect(findLunchText, findsOneWidget);
//   expect(findDinnerText, findsOneWidget);
//   expect(findOptionA, findsOneWidget);
//   expect(findOptionB, findsOneWidget);
//   expect(findOptionC, findsOneWidget);
//   expect(findIcon, findsWidgets);
//   await tester.tap(findLunchText);
//   await tester.pumpAndSettle();
//
//   expect(findOptionA, findsOneWidget);
//   expect(findOptionB, findsOneWidget);
//   expect(findOptionC, findsOneWidget);
//
//   await tester.tap(findDinnerText);
//   await tester.pumpAndSettle();
//
//   expect(findOptionA, findsOneWidget);
//   expect(findOptionB, findsOneWidget);
//   expect(findOptionC, findsOneWidget);
//
//   preferences.clear();
// }
