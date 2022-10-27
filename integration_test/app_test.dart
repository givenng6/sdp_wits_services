import 'package:flutter/cupertino.dart';
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

  await _login(tester);
  await _buses(tester);
  await _diningHall(tester);
  await _protection(tester);
  await _events(tester);
  await _ccdu(tester);
  await _campusHealth(tester);
  await _profile(tester);

  await tester.pump(const Duration(seconds: 10));
  await preferences.clear();
}

Future<void> _login(WidgetTester tester) async{
  final continueAsStudentButton = find.byKey(const Key('Continue as Student'));
  await tester.pump(const Duration(seconds: 5));
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

Future<void> _buses(WidgetTester tester) async {
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

Future<void> _diningHall(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Dining Hall'), warnIfMissed: false);
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
  await tester.tap(find.byKey(const Key('card0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byType(Icon), warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> _protection(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Protection'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Book Ride'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('From'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('From'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('To'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('To'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Book'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 5));
  await Future.delayed(const Duration(seconds: 5));
  await tester.pump(const Duration(seconds: 5));

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Cancel Ride'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Go Back'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Cancel Ride'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('Cancel Ride')), warnIfMissed: false);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
}

Future<void> _events(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Menu'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Events'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('like0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('image0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.close), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.arrow_back), warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> _ccdu(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Counselling Careers Development Unit'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('New Session'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Submit'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.arrow_back), warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> _campusHealth(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Campus Health'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.arrow_back), warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> _profile(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('G'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(CupertinoIcons.moon_stars), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.logout_rounded), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Cancel'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('unsubscribe0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.logout_rounded), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byIcon(Icons.logout_rounded), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Sign Out'), warnIfMissed: false);
  await tester.pumpAndSettle();
}