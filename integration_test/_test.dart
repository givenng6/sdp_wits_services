import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Home/Start.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end start test", () {
    testWidgets("start", _start);
  });
}

Future<void> _start(WidgetTester tester) async {
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MaterialApp(home: Start(email: '2375736@students.wits.ac.za', username: 'Nathi',)),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));

  expect(find.text('Campus Control'), findsWidgets);
  expect(find.text('Ride Request'), findsWidgets);
  expect(find.text('Dashboard'), findsWidgets);
  expect(find.text('Buses'), findsWidgets);
  expect(find.text('Dining Hall'), findsWidgets);
  expect(find.text('Protection'), findsWidgets);
  expect(find.text('Menu'), findsWidgets);
  expect(find.byType(Icon), findsWidgets);

  await tester.pump(const Duration(seconds: 2));
}
