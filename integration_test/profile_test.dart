// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:provider/provider.dart';
// import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart' as staff;
// import 'package:sdp_wits_services/StudentsApp/Profile/Profile.dart' as students;
// import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
// import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   group("end-to-end buses test", () {
//     testWidgets("Students Profile", _studentsProfileTests);
//
//     testWidgets("Staff Profile", _staffProfileTests);
//   });
// }
//
// Future<void> _studentsProfileTests(WidgetTester tester)async{
//   const username = 'Nkosinathi Chuma';
//   const email = 'a2375736@wits.ac.za';
//   const subs = <String>['Dining Services', 'Bus Services', 'Campus Control'];
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.setString('username', username);
//   preferences.setString('email', email);
//   await tester.pumpAndSettle();
//   await tester.pump(const Duration(seconds: 1));
//
//   Widget widget = MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (_) => Subscriptions()),
//       ChangeNotifierProvider(create: (_) => UserData()),
//     ],
//     child: const MaterialApp(
//         home: students.Profile(isTesting: true, email: email, username: username, subs: subs,)),
//   );
//
//   await tester.pumpWidget(widget);
//   await tester.pumpAndSettle();
//
//   await tester.pumpAndSettle();
//   final findUsername = find.text(username);
//   final findEmail = find.text(email);
//   final findIconButtons = find.byType(IconButton);
//   final findIcon = find.byType(Icon);
//   final findClipOval = find.byType(ClipOval);
//   final findDiningServicesText = find.text(subs[0]);
//   final findBusServicesText = find.text(subs[1]);
//   final findProtectionServicesText = find.text(subs[2]);
//   final findSubscriptionsText = find.text('Subscriptions');
//
//   // await tester.pump(const Duration(seconds: 5));
//   expect(findUsername, findsOneWidget);
//   expect(findEmail, findsOneWidget);
//   expect(findIcon, findsWidgets);
//   expect(findIconButtons, findsWidgets);
//   expect(findClipOval, findsWidgets);
//   expect(findDiningServicesText, findsOneWidget);
//   expect(findBusServicesText, findsOneWidget);
//   expect(findProtectionServicesText, findsOneWidget);
//   expect(findSubscriptionsText, findsOneWidget);
//
//   await tester.tap(find.byKey(const Key('Logout')));
//   await tester.pumpAndSettle();
//   expect(find.text('Are you sure you want to Sign Out?'), findsOneWidget);
//   expect(find.text('Sign Out'), findsOneWidget);
//   expect(find.text('Cancel'), findsOneWidget);
//
//   await tester.pump(const Duration(seconds: 3));
//   preferences.clear();
// }
//
// Future<void> _staffProfileTests(WidgetTester tester)async{
//   const username = 'Nkosinathi Chuma';
//   const email = 'a2375736@wits.ac.za';
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.setString('username', username);
//   preferences.setString('email', email);
//   await tester.pumpAndSettle();
//   await tester.pump(const Duration(seconds: 1));
//
//   Widget widget = MaterialApp(
//     home: staff.Profile(email, username),
//   );
//   await tester.pumpWidget(widget);
//   await tester.pumpAndSettle();
//
//   await tester.pumpAndSettle();
//   final findUsername = find.text(username);
//   final findEmail = find.text(email);
//   final findIconButtons = find.byType(IconButton);
//   final findIcon = find.byType(Icon);
//   final findClipOval = find.byType(ClipOval);
//   expect(findUsername, findsOneWidget);
//   expect(findEmail, findsOneWidget);
//   expect(findIcon, findsWidgets);
//   expect(findIconButtons, findsWidgets);
//   expect(findClipOval, findsWidgets);
//
//   await tester.tap(find.byKey(const Key('Logout')));
//   await tester.pumpAndSettle();
//   expect(find.text('Are you sure you want to Sign Out?'), findsOneWidget);
//   expect(find.text('Sign Out'), findsOneWidget);
//   expect(find.text('Cancel'), findsOneWidget);
//
//   await tester.pump(const Duration(seconds: 0));
//   preferences.clear();
// }