import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/main.dart' as app;

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end start test", () {
    testWidgets("students app", _studentsAppTest);
  });
}

Future<void> _studentsAppTest(WidgetTester tester) async {
  app.main();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 7500));
  await tester.pumpAndSettle();

  await login(tester);
  await buses(tester);

  await tester.pump(const Duration(seconds: 10));
  await preferences.clear();
}

Future<void> login(WidgetTester tester) async{
  final continueAsStudentButton = find.byKey(const Key('Continue as Student'));
  await tester.pumpAndSettle();
  await tester.tap(continueAsStudentButton, warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tester.enterText(findNameTextField(), '2375736@students.wits.ac.za');
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.enterText(findPasswordTextField(), '2375736');
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('LOGIN'), warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> buses(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Buses'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('follow0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('follow1')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('follow2')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('status0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('status0')), warnIfMissed: false);
  await tester.pumpAndSettle();
}