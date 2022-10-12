import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Menu/Menu.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end menu test", () {
    // testWidgets("Menu", _menuTests);
  });
}

Future<void> _menuTests(WidgetTester tester)async{
  const username = 'Nkosinathi Chuma';
  const email = 'a2375736@wits.ac.za';
  const menu = 'Menu';
  var subs = ['Dining Services', 'Bus Services', 'Campus Control'];
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('username', username);
  preferences.setString('email', email);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MaterialApp(
        home: Menu(onNavigate: (int index) {  },)),
  );

  await tester.pumpWidget(widget);

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
  final findUsername = find.text(username);
  final findUserInitial = find.text(username[0]);
  final findIcon = find.byType(Icon);
  final findMenuText = find.text(menu);
  expect(findUsername, findsOneWidget);
  expect(findUserInitial, findsOneWidget);
  expect(findIcon, findsWidgets);
  expect(findMenuText, findsOneWidget);

  expect(find.text('Buses'), findsOneWidget);
  expect(find.text('Dining Services'), findsOneWidget);
  expect(find.text('Protection'), findsOneWidget);
  expect(find.text('Campus Health'), findsOneWidget);
  expect(find.text('CCDU'), findsOneWidget);
  expect(find.text('Events'), findsOneWidget);

  expect(find.text('version 1.0.2 (sprint2)'), findsOneWidget);

  await tester.pump(const Duration(seconds: 1));
  preferences.clear();
}