import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EventsController extends GetxController {
  var events = [].obs;

  getEvents() async {
    String uri = 'https://sdpwitsservices-production.up.railway.app/';
    // String uri = 'http://192.168.20.17:5000/';

    List<String> expiredEvents = [];
    await http.get(
      Uri.parse('${uri}getEvents'),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
    ).then((value) {
      List events = jsonDecode(value.body).toList();
      for (var event in events) {
        List date = event['date'].split('/');
        List time = event['time'].split(':');

        int eventDate =
            int.parse(date[2] + date[1] + date[0] + time[0] + time[1]);

        int currDate = int.parse(DateTime.now().year.toString() +
            DateTime.now().month.toString().padLeft(2, '0') +
            DateTime.now().day.toString().padLeft(2, '0') +
            DateTime.now().hour.toString().padLeft(2, '0') +
            DateTime.now().minute.toString().padLeft(2, '0'));

        if (eventDate < currDate) {
          expiredEvents.add(event['id'].toString());
        }
      }
      this.events(jsonDecode(value.body).toList());
    });

    if(expiredEvents.isNotEmpty){
      await http.post(
        Uri.parse('${uri}deleteExpiredEvents'),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, List<String>>{
          'ids': expiredEvents,
        })
      ).then((value) => getEvents());
    }
  }
}
