// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:sdp_wits_services/main.dart' as app;
// import 'package:sdp_wits_services/StaffApp/Dining/mealSelectionPage.dart' as dining;
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   group("end-to-end dining test", () {
//     testWidgets("Staff Dining", (tester) async {
//       app.main();
//       await tester.pumpAndSettle();
//       await tester.pump(const Duration(seconds: 5));
//       Widget createWidgetForTesting({required Widget child}) {
//         return MaterialApp(
//           home: child,
//         );
//       }
//       const username = 'Lindokuhle Mabena';
//       const email = 'a2355285@wits.ac.za';
//       const dhName = 'Ernest Openheimer';
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       preferences.setString('username', username);
//       preferences.setString('email', email);
//       preferences.setString('dhName', dhName);
//       await tester.pumpAndSettle();
//       await tester.pump(const Duration(seconds: 2));
//       await tester.pumpWidget(createWidgetForTesting(child: dining.mealSelecionPage()));

//       await tester.pump(const Duration(seconds: 3));
//       final findDHTitle = find.text(dhName);
//       final findUserInitial = find.text('L');
//       final findBreakfastText = find.text('Breakfast');
//       final findLunchText = find.text('Lunch');
//       final findDinnerText = find.text('Dinner');
//       final findIcon = find.byType(Icon);
//       expect(findDHTitle, findsOneWidget);
//       expect(findUserInitial, findsOneWidget);
//       expect(findBreakfastText, findsOneWidget);
//       expect(findLunchText, findsOneWidget);
//       expect(findDinnerText, findsOneWidget);
//       expect(findIcon, findsWidgets);

//       await tester.pump(const Duration(seconds: 1));
//       await tester.tap(findLunchText);
//       await tester.pump(const Duration(seconds: 1));
//       await tester.tap(findDinnerText);
//       await tester.pump(const Duration(seconds: 1));
//       preferences.clear();
//     });
//   });
// }
