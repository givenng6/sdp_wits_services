import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StaffApp/Buses/Controller/buses_controller.dart';
import 'package:sdp_wits_services/StaffApp/Events/Controllers/events_controller.dart';
import 'package:sdp_wits_services/StaffApp/Events/Views/events.dart';
import 'package:sdp_wits_services/StudentsApp/Home/Start.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/protection.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end start test", () {
    testWidgets("start", _start);
  });
}

Future<void> _start(WidgetTester tester) async {
  Widget widget = MaterialApp(
    builder: (_, __){
      return const Events();
    },
  );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('like0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.byKey(const Key('image0')), warnIfMissed: false);
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 10));
}
