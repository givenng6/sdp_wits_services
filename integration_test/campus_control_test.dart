import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/protection.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end dashboard test", () {
    testWidgets("Unsubscribed Campus Control", _campusControlUnsubscribedTest);
    testWidgets("Subscribed Campus Control", _campusControlSubscribedTest);
  });
}

Future<void> _campusControlUnsubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const MaterialApp(home: Protection()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 10));

  expect(
      find.text('To access this service you must be subscribed'), findsWidgets);
  expect(find.text('Campus Control'), findsWidgets);
  expect(find.text('Subscribe'), findsWidgets);
  expect(find.text('Book Ride'), findsWidgets);

  await tester.pump(const Duration(seconds: 10));
}

Future<void> _campusControlSubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, child){
      set() async{
        await Future.delayed(const Duration(seconds: 1));
          context.read<Subscriptions>().addSub('campus_control');
      }set();

      return const MaterialApp(
          home: Protection());
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  expect(find.text('About Protection Services'), findsWidgets);
  expect(find.text('Campus Control'), findsWidgets);
  expect(find.text('Book Ride'), findsWidgets);
  expect(find.byType(Icon), findsWidgets);

  await tester.tap(find.text('Book Ride'));
  await tester.pumpAndSettle();

  expect(find.text('From'), findsWidgets);
  expect(find.text('To'), findsWidgets);
  expect(find.text('Book'), findsWidgets);

  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text('To'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));

  expect(find.text('Student digz'), findsWidgets);

  await tester.tap(find.text('Campus Control'), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 2));

  await tester.tap(find.text('From'), warnIfMissed: false);
  await tester.pumpAndSettle();

  expect(find.text('Main Campus'), findsWidgets);

  await tester.pump(const Duration(seconds: 10));
}
