// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:provider/provider.dart';
// import 'package:sdp_wits_services/StudentsApp/Dining/Dining.dart';
// import 'package:sdp_wits_services/StudentsApp/Dining/ViewDH.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
// import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
// import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   group("end-to-end students dining test", () {
//     testWidgets("Unsubscribed Students Dining", _unSubbedDiningTests);
//     testWidgets("Subscribed Students Dining", _subbedDiningTests);
//     testWidgets("Main Dining", _mainDiningTests);
//   });
// }
// String uri = "https://web-production-8fed.up.railway.app/";
//
// Future<void> _unSubbedDiningTests(WidgetTester tester)async{
//   const username = 'Nkosinathi Chuma';
//   const email = '2375736@students.wits.ac.za';
//   var diningHalls = [];
//
//   await http.get(Uri.parse("${uri}db/getDiningHalls/"),
//       headers: <String, String>{
//         "Accept": "application/json",
//         "Content-Type": "application/json; charset=UTF-8",
//       }).then((response) {
//     var toJSON = jsonDecode(response.body);
//     for (var data in toJSON) {
//       diningHalls.add(DiningObject(
//           data['name'],
//           data['id'],
//           data['breakfast']['optionA'],
//           data['breakfast']['optionB'],
//           data['breakfast']['optionC'],
//           data['lunch']['optionA'],
//           data['lunch']['optionB'],
//           data['lunch']['optionC'],
//           data['dinner']['optionA'],
//           data['dinner']['optionB'],
//           data['dinner']['optionC']));
//     }
//   });
//
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
//         home: Dining()),
//   );
//
//   await tester.pumpWidget(widget);
//
//   await tester.pumpAndSettle();
//
//   await tester.pumpAndSettle();
//   expect(find.text('Dining Services'), findsOneWidget);
//   expect(find.text('To access this service you must be subscribed'), findsWidgets);
//   expect(find.text('Subscribe'), findsOneWidget);
//
//   await tester.pump(const Duration(seconds: 3));
//   preferences.clear();
// }
//
// Future<void> _subbedDiningTests(WidgetTester tester)async{
//   const username = 'Nkosinathi Chuma';
//   const email = '2375736@students.wits.ac.za';
//   var diningHalls = <DiningObject>[];
//
//   await http.get(Uri.parse("${uri}db/getDiningHalls/"),
//       headers: <String, String>{
//         "Accept": "application/json",
//         "Content-Type": "application/json; charset=UTF-8",
//       }).then((response) {
//     var toJSON = jsonDecode(response.body);
//     for (var data in toJSON) {
//       diningHalls.add(DiningObject(
//           data['name'],
//           data['id'],
//           data['breakfast']['optionA'],
//           data['breakfast']['optionB'],
//           data['breakfast']['optionC'],
//           data['lunch']['optionA'],
//           data['lunch']['optionB'],
//           data['lunch']['optionC'],
//           data['dinner']['optionA'],
//           data['dinner']['optionB'],
//           data['dinner']['optionC']));
//     }
//   });
//
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
//     child: MaterialApp(
//         home: Dining(isTesting: true, email: email, diningHalls: diningHalls,)),
//   );
//
//   await tester.pumpWidget(widget);
//   await tester.pump(const Duration(seconds: 3));
//
//   await tester.pumpAndSettle();
//   expect(find.text('Dining Services'), findsOneWidget);
//   expect(find.text('Follow'), findsWidgets);
//   expect(find.text('Following'), findsOneWidget);
//   expect(find.text('Main'), findsOneWidget);
//   expect(find.text('Jubilee'), findsOneWidget);
//   expect(find.text('Convocation'), findsOneWidget);
//   expect(find.text('Highfield'), findsOneWidget);
//   expect(find.text('Ernest Openheimer'), findsOneWidget);
//   expect(find.text('Knockando'), findsOneWidget);
//   expect(find.text('A44 Wits East Campus'), findsWidgets);
//
//   await tester.pump(const Duration(seconds: 3));
//   preferences.clear();
// }
//
// Future<void> _mainDiningTests(WidgetTester tester)async{
//   const username = 'Nkosinathi Chuma';
//   const email = '2375736@students.wits.ac.za';
//   var diningHalls = [];
//
//   await http.get(Uri.parse("${uri}db/getDiningHalls/"),
//       headers: <String, String>{
//         "Accept": "application/json",
//         "Content-Type": "application/json; charset=UTF-8",
//       }).then((response) {
//     var toJSON = jsonDecode(response.body);
//     for (var data in toJSON) {
//       diningHalls.add(DiningObject(
//           data['name'],
//           data['id'],
//           data['breakfast']['optionA'],
//           data['breakfast']['optionB'],
//           data['breakfast']['optionC'],
//           data['lunch']['optionA'],
//           data['lunch']['optionB'],
//           data['lunch']['optionC'],
//           data['dinner']['optionA'],
//           data['dinner']['optionB'],
//           data['dinner']['optionC']));
//     }
//   });
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.setString('username', username);
//   preferences.setString('email', email);
//   await tester.pumpAndSettle();
//   await tester.pump(const Duration(seconds: 1));
//
//   await tester.pumpWidget(HookBuilder(builder: (context) {
//     return MaterialApp(home: ViewDH(diningHalls[0]));
//   }));
//
//   await tester.pumpAndSettle();
//
//   await tester.pumpAndSettle();
//   expect(find.text('Main'), findsOneWidget);
//   expect(find.text('Breakfast'), findsWidgets);
//   expect(find.text('Lunch'), findsWidgets);
//   expect(find.text('Dinner'), findsWidgets);
//   expect(find.text('Option 1'), findsWidgets);
//   expect(find.text('Option 2'), findsWidgets);
//   expect(find.text('Option 3'), findsWidgets);
//
//   for(int i = 0; i < diningHalls[0].bfA.length; i++) {
//     expect(find.text(diningHalls[0].bfA[i]), findsWidgets);
//   }
//   for(int i = 0; i < diningHalls[0].bfB.length; i++) {
//     expect(find.text(diningHalls[0].bfB[i]), findsWidgets);
//   }
//   for(int i = 0; i < diningHalls[0].bfC.length; i++) {
//     expect(find.text(diningHalls[0].bfC[i]), findsWidgets);
//   }
//   for(int i = 0; i < diningHalls[0].lA.length; i++) {
//     expect(find.text(diningHalls[0].lA[i]), findsWidgets);
//   }
//   for(int i = 0; i < diningHalls[0].lB.length; i++) {
//     expect(find.text(diningHalls[0].lB[i]), findsWidgets);
//   }
//   for(int i = 0; i < diningHalls[0].lC.length; i++) {
//     expect(find.text(diningHalls[0].lC[i]), findsWidgets);
//   }
//   for(int i = 0; i < diningHalls[0].dA.length; i++) {
//     expect(find.text(diningHalls[0].dA[i]), findsWidgets);
//   }
//   for(int i = 0; i < diningHalls[0].dB.length; i++) {
//     expect(find.text(diningHalls[0].dB[i]), findsWidgets);
//   }
//   for(int i = 0; i < diningHalls[0].dC.length; i++) {
//     expect(find.text(diningHalls[0].dC[i]), findsWidgets);
//   }
//
//   await tester.pump(const Duration(seconds: 10));
//   preferences.clear();
// }
//
