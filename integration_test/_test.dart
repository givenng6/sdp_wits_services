import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StaffApp/Buses/Controller/buses_controller.dart';
import 'package:sdp_wits_services/StaffApp/Events/Controllers/events_controller.dart';
import 'package:sdp_wits_services/StudentsApp/Events/Events.dart';
import 'package:sdp_wits_services/StudentsApp/Events/events_object.dart';
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
  Widget widget = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Subscriptions()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    builder: (context, child) {
      Get.put(Booked());
      final eventsController = Get.put(EventsController());
      eventsController.getEvents();
      set()async{
        Future<void> getEvents(BuildContext context) async {
          await eventsController.getEvents();
          await http.get(Uri.parse("${uri}db/getEvents/"), headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          }).then((response) {
            var data = jsonDecode(response.body);
            List<EventObject> events = [];
            for(dynamic event in data){
              List<String> likes = [];
              for(String like in event["likes"]){
                likes.add(like);
              }
              EventObject curr = EventObject(event['title'], event['date'], event['time'], likes, event['venue'], event['type'], event['id'], event['imageUrl']);
              events.add(curr);
            }
            context.read<Subscriptions>().setEvents(events);
          });
        }
        await getEvents(context);
        Random rnd = Random();
        int studentNumber = 1912345 + rnd.nextInt(2512345 - 1912345);
        context.read<UserData>().setEmail('$studentNumber@students.wits.ac.za');
      }set();
      final busesController = Get.put(BusesController());
      busesController.getSharedPreferences();
      busesController.getRoutes();
      return const MaterialApp(home: Events());
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
