import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDU.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end ccdu test", () {
    testWidgets("Unsubscribed ccdu", _ccduUnsubscribedTest);
    testWidgets("Subscribed ccdu", _ccduSubscribedTest);
  });
}

Future<void> _ccduUnsubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: const MaterialApp(home: CCDU()),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 10));

  expect(find.text('CCDU'), findsWidgets);
  // expect(find.text('Campus Control'), findsWidgets);
  expect(find.text('No Data'), findsWidgets);
  expect(find.text('New Session'), findsWidgets);

  await tester.pump(const Duration(seconds: 10));
}

Future<void> _ccduSubscribedTest(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, child) {
      set()async{
        await Future.delayed(const Duration(seconds: 1));
        CCDUObject session = CCDUObject();
        session.setAppointment(
            'Pending',
            '12:30-13:30',
            '06/10/2022',
            'Meeting',
            't2375736@wits.ac.za',
            'Dr AP Chuma',
            'Online');
        context.read<Subscriptions>().addCCDUBooking(session);
      }set();
      return const MaterialApp(home: CCDU());
    },
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  expect(find.text('CCDU'), findsWidgets);
  // expect(find.text('Campus Control'), findsWidgets);
  expect(find.text('Appointment 1'), findsWidgets);
  expect(find.text('Date: 06/10/2022'), findsWidgets);
  expect(find.text('Time: 12:30-13:30'), findsWidgets);
  expect(find.text('Counsellor: Dr AP Chuma'), findsWidgets);
  expect(find.text('Pending'), findsWidgets);
  expect(find.text('New Session'), findsWidgets);

  await tester.pump(const Duration(seconds: 2));
}
