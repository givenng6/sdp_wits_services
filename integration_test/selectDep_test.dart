import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sdp_wits_services/StaffApp/StaffPage.dart';
import 'package:sdp_wits_services/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end dashboard test", () {
    testWidgets("SelectDepartment", _selectDepTest);
    testWidgets("Check Buses", _checkBuses);
    testWidgets("Check Campus Control", _checkCampusControl);

  });
}
Future<void> _selectDepTest(WidgetTester tester) async {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a2355285@wits.ac.za");
  sharedPreferences.setString("username", "Sabelo Mabena");
  await globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const MaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  expect(find.byKey(Key("logoImg")),findsOneWidget);
  expect(find.text("Departments"),findsOneWidget);

  final findDining = find.text("Dining Services");
  expect(findDining,findsWidgets);

  await tester.tap(findDining);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(find.text("Convocation"));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.pumpAndSettle();

  final editIcon = find.byKey(const Key("Option A breakfast Edit"));
  expect(editIcon,findsWidgets);

  await tester.tap(editIcon);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item = find.text("Corn Flakes");
  expect(item,findsOneWidget);

  await tester.tap(item);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final confirmBtn = find.byIcon(Icons.check);
  expect(confirmBtn,findsOneWidget);

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  // expect(find.byKey(const Key('loading')),findsWidgets);

  await tester.pumpAndSettle(const Duration(seconds: 5));
  await tester.pumpAndSettle();

  //Lunch

  final lunchTab = find.byKey(const Key('lunchTab'));
  expect(lunchTab,findsOneWidget);

  await tester.tap(lunchTab);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final editIcon2 = find.byKey(Key("Option A lunch Edit"));
  expect(editIcon2,findsWidgets);

  await tester.tap(editIcon2);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item2 = find.text("Pizza");
  expect(item2,findsWidgets);

  await tester.tap(item2);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  expect(confirmBtn,findsOneWidget);

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  // Dinner

  await tester.pumpAndSettle();

  final dinnerTab = find.byKey(const Key('dinnerTab'));
  expect(dinnerTab,findsOneWidget);

  await tester.tap(dinnerTab);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final editIcon3 = find.byKey(Key("Option A dinner Edit"));
  expect(editIcon3,findsWidgets);

  await tester.tap(editIcon3);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  final item3 = find.text("Ham");
  expect(item3,findsWidgets);

  await tester.tap(item3);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  expect(confirmBtn,findsOneWidget);

  await tester.tap(confirmBtn);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  sharedPreferences.clear();

}

Future<void> _checkBuses(WidgetTester tester) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a23552855@wits.ac.za");
  sharedPreferences.setString("username", "tester");
  await globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const MaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  final card = find.text("Bus Services");
  expect(card,findsOneWidget);

  await tester.tap(card);
  await tester.pumpAndSettle(const Duration(seconds: 3));
  expect(find.text("Buses"),findsWidgets);

  await tester.pumpAndSettle();
  sharedPreferences.clear();

}

Future<void> _checkCampusControl(WidgetTester tester) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("email", "a23552855@wits.ac.za");
  sharedPreferences.setString("username", "tester");
  await globals.getSharedPreferences();

  await tester.pumpWidget(HookBuilder(builder: (context) {
    return const MaterialApp(home: StaffPage());
  }));

  await tester.pumpAndSettle(const Duration(seconds: 1));

  final card = find.text("Campus Control");
  expect(card,findsOneWidget);

  await tester.tap(card);
  await tester.pumpAndSettle(const Duration(seconds: 3));
  expect(find.text("Vehicles"),findsWidgets);

  await tester.pumpAndSettle();
  sharedPreferences.clear();
}
