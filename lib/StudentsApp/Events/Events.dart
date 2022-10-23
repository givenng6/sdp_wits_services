import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:sdp_wits_services/StudentsApp/Events/events_object.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/PushNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../StaffApp/Events/Controllers/events_controller.dart';

// Uri to the API
String link = "https://web-production-a9a8.up.railway.app/";

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _Events();
}

class _Events extends State<Events> {
  final eventsController = Get.find<EventsController>();
  List<EventObject> events = [];
  String email = "";

  late final PushNotification pushNotification;

  @override
  void initState(){
    pushNotification = PushNotification();
    pushNotification.initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    events = context.watch<Subscriptions>().events;
    email = context.watch<UserData>().email;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          backgroundColor: const Color(0xff003b5c),
        ),
        body: RefreshIndicator(
          onRefresh: () => getEvents(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [showEvents()],
            ),
          ),
        ),
    );
  }

  Widget eventCard(String eventTitle, String date, String time,
      List<String> likes, String venue, String type, String eventID) {
    String img = "";
    Color buttonColor;
    bool isDark;

    // change the visuals depending on the type of the event...
    switch (type) {
      case "Sport":
        img = "assets/events_sport.png";
        buttonColor = const Color(0xff86B049);
        isDark = true;
        break;
      case "Hackathon":
        img = 'assets/events_hack.jpeg';
        buttonColor = const Color(0xff000000);
        isDark = true;
        break;
      case "Religion":
        img = "assets/events_religion.jpeg";
        buttonColor = const Color(0xffff7700);
        isDark = true;
        break;
      case "Awareness":
        img = "assets/events_awareness.jpeg";
        buttonColor = const Color(0xffe5e4e2);
        isDark = false;
        break;
      case "Concert":
        img = "assets/events_concert.jpeg";
        buttonColor = const Color(0x80b0c4de);
        isDark = false;
        break;
      case "Entertainment":
        img = "assets/events_entertainment.jpeg";
        buttonColor = const Color(0xff1974d2);
        isDark = true;
        break;
      case "Politics":
        img = "assets/events_politics.jpeg";
        buttonColor = const Color(0x801e69cf);
        isDark = true;
        break;
      default:
        img = "assets/events_other.jpeg";
        buttonColor = const Color(0xfff8ed62);
        isDark = false;
        break;
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: Image.asset(img),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(date,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey)),
                      Text(time,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      eventTitle,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: buttonColor,
                          shape: const StadiumBorder()),
                      onPressed: () async{
                        if (!likes.contains(email)) {
                          // add like to the event
                          for (int i = 0; i < events.length; i++) {
                            String id = events[i].eventID;
                            if (id == eventID) {
                              context.read<Subscriptions>().likeEvent(email, i);
                              addLike(context, email, eventID);
                              break;
                            }
                          }
                        }
                        // schedule a reminder
                        // scheduledEvents
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        List<String>? scheduledEvents = prefs.getStringList("scheduledEvents");

                        DateTime now = DateTime.now();
                        String timeNow = DateFormat('kk:mm').format(now);
                        String dateNow = DateFormat('dd/MM/yyyy').format(now);

                        if(!scheduledEvents!.contains(eventID) && date == dateNow){
                          int nowTimeInSec = (int.parse(timeNow.split(":")[0]) * 3600) + (int.parse(timeNow.split(":")[1]) * 60);
                          int timeInSec = (int.parse(time.split(":")[0]) * 3600) + (int.parse(time.split(":")[1]) * 60);

                          int timeToNotify = timeInSec - 3600 - nowTimeInSec;

                          scheduledEvents.add(eventID);
                          prefs.setStringList("scheduledEvents", scheduledEvents);

                          if(timeToNotify > 0){
                            pushNotification.scheduleNotification(id: 4, title: "Wits Events", body: "$eventTitle happening in an hour", seconds: timeToNotify);
                          }
                          // To Empty the list
                          //prefs.setStringList("scheduledEvents", []);
                          print(timeToNotify);
                          print(prefs.getStringList("scheduledEvents"));
                        }

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isDark
                              ? Row(
                                  children: const [
                                    Text(
                                      'Interested on the event',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.open_in_new,
                                      color: Colors.white,
                                    )
                                  ],
                                )
                              : Row(
                                  children: const [
                                    Text(
                                      'Interested on the event',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.open_in_new,
                                      color: Colors.black,
                                    )
                                  ],
                                )
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        addOns("LIKES", likes.length.toString()),
                        addOns("VENUE", venue),
                        addOns("TYPE", type)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addOns(String title, String size) {
    String display = "";
    if(size.length > 20){
      for(int i = 0; i < 20; i++){
        display += size[i];
      }
      display += "...";
    }else{
      display = size;
    }
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Text(display, style: const TextStyle(fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget showEvents() {
    List<Widget> items = [];

    for (EventObject event in events) {
      items.add(eventCard(event.eventTitle, event.date, event.time, event.likes,
          event.venue, event.type, event.eventID));
    }

    return Column(children: items);
  }

  Future<void> addLike(
      BuildContext context, String email, String eventID) async {
    await http.post(Uri.parse("${link}db/addLike/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "id": eventID,
        }));
  }

  Future<void> getEvents(BuildContext context) async {
    await eventsController.getEvents();
    await http.get(Uri.parse("${link}db/getEvents/"), headers: <String, String>{
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
        EventObject curr = EventObject(event['title'], event['date'], event['time'], likes, event['venue'], event['type'], event['id']);
        events.add(curr);
      }
      context.read<Subscriptions>().setEvents(events);
    });
  }
}
