import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/ride_object.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/PushNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../StaffApp/Events/Controllers/events_controller.dart';
import '../Providers/Subscriptions.dart';
import '../Buses/BusObject.dart';
import '../Dining/DiningObject.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/StudentsApp/Home/Home.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sdp_wits_services/StudentsApp/Events/events_object.dart';

// Uri to the API
String uri = "https://web-production-a9a8.up.railway.app/";

class Start extends StatefulWidget {
  String email, username;

  Start({super.key, required this.email, required this.username});

  @override
  State<Start> createState() => _Start();
}

class _Start extends State<Start> {
  final eventsController = Get.find<EventsController>();
  bool isLoading = true;
  late final PushNotification pushNotification;

  @override
  void initState() {
    pushNotification = PushNotification();
    pushNotification.initNotifications();
    getSubs(context);
    getBusFollowing(context);
    getBusSchedule(context);
    getDiningHallFollowing(context);
    getDiningHalls(context);
    getCCDUBookings(context);
    getCounsellors(context);
    getMealTime(context);
    getEvents(context);
    getRideDetails(context);
    setDailyNotifications();
    super.initState();
  }

  Future<void> getSubs(BuildContext context) async {
    await http
        .post(Uri.parse("${uri}db/getSub/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": widget.email,
            }))
        .then((value) {
      var json = jsonDecode(value.body);
      // update the sub provider
      for (String service in json["subs"]) {
        context.read<Subscriptions>().addSub(service);
      }
    });
  }

  Future<void> getBusFollowing(BuildContext context) async {
    await http
        .post(Uri.parse("${uri}db/getBusFollowing/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": widget.email,
            }))
        .then((value) {
      var busData = jsonDecode(value.body);
      List<String> busFollowing = [];
      for (String bus in busData) {
        busFollowing.add(bus);
      }
      context.read<Subscriptions>().updateBusFollowing(busFollowing);
    });
  }

  Future<void> getBusSchedule(BuildContext context) async {
    await http.get(Uri.parse("${uri}db/getBusSchedule/"), headers: <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8",
    }).then((response) {
      var toJSON = jsonDecode(response.body);
      List<BusObject> tempSchedule = [];
      for (var data in toJSON) {
        String pos = "";
        if (data['position'] != null) {
          pos = data['position'];
        }
        tempSchedule.add(BusObject(
            data['name'], data['id'], data['stops'], data['status'], pos));
      }
      context.read<Subscriptions>().setBusSchedule(tempSchedule);
      context.read<UserData>().setEmail(widget.email);
      context.read<UserData>().setUsername(widget.username);
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      });
    });
  }

  Future<void> getDiningHallFollowing(BuildContext context) async {
    await http
        .post(Uri.parse("${uri}db/getDiningHallFollowing/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": widget.email,
            }))
        .then((value) {
      var data = jsonDecode(value.body);
      context.read<Subscriptions>().updateDHFollowing(data);
    });
  }

  Future<void> getDiningHalls(BuildContext context) async {
    await http
        .get(Uri.parse("${uri}db/getDiningHalls/"), headers: <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8",
    }).then((response) {
      var toJSON = jsonDecode(response.body);
      List<DiningObject> tempList = [];
      for (var data in toJSON) {
        tempList.add(DiningObject(
            data['name'],
            data['id'],
            data['breakfast']['optionA'],
            data['breakfast']['optionB'],
            data['breakfast']['optionC'],
            data['lunch']['optionA'],
            data['lunch']['optionB'],
            data['lunch']['optionC'],
            data['dinner']['optionA'],
            data['dinner']['optionB'],
            data['dinner']['optionC']));
      }
      context.read<Subscriptions>().setDiningHalls(tempList);
    });
  }

  Future<void> getMealTime(BuildContext context) async {
    await http.get(Uri.parse("${uri}db/getTime/"), headers: <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8",
    }).then((response) {
      var data = jsonDecode(response.body);
      context.read<Subscriptions>().setMealTime(data);
    });
  }

  Future<void> getCCDUBookings(BuildContext context) async {
    await http.post(Uri.parse("${uri}db/getBookingCCDU/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": widget.email,
            }))
        .then((value) async {
      var data = jsonDecode(value.body);

      for (dynamic object in data) {
        CCDUObject session = CCDUObject();
        session.setAppointment(
            object['id'],
            object['status'],
            object['time'],
            object['date'],
            object['description'],
            object['counsellor'],
            object['counsellorName'],
            object['location']);
        context.read<Subscriptions>().addCCDUBooking(session);

        String id = object['id'];
        String status = object['status'];
        String date = object['date'];
        String mixedTime = object['time'];
        String time = mixedTime.split("-")[0];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String>? scheduledEvents = prefs.getStringList("scheduledCCDU");

        DateTime now = DateTime.now();
        String timeNow = DateFormat('kk:mm').format(now);
        String dateNow = DateFormat('dd/MM/yyyy').format(now);

        if(scheduledEvents != null){
          if(!scheduledEvents.contains(id) && date == dateNow && status == 'Confirmed'){
            int nowTimeInSec = (int.parse(timeNow.split(":")[0]) * 3600) + (int.parse(timeNow.split(":")[1]) * 60);
            int timeInSec = (int.parse(time.split(":")[0]) * 3600) + (int.parse(time.split(":")[1]) * 60);

            int timeToNotify = timeInSec - 3600 - nowTimeInSec;

            scheduledEvents.add(id);
            prefs.setStringList("scheduledCCDU", scheduledEvents);
            if(timeToNotify > 0){
              pushNotification.scheduleNotification(id: 6, title: "CCDU Appointment", body: "You have an appointment in an hour", seconds: timeToNotify);
            }

            // To Empty the list
            //prefs.setStringList("scheduledEvents", []);
            print(timeToNotify);
            print(prefs.getStringList("scheduledCCDU"));
          }
        }
      }
    });
  }

  Future<void> getCounsellors(BuildContext context) async {
    await http
        .get(Uri.parse("${uri}db/getCounsellors/"), headers: <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8",
    }).then((response) {
      var data = jsonDecode(response.body);

      for (var counsellor in data) {
        String email = counsellor['email'];
        String username = counsellor['username'];
        context.read<Subscriptions>().addCounsellor(email, username);
      }
      context.read<Subscriptions>().addCounsellor("", "");
    });
  }

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
        EventObject curr = EventObject(event['title'], event['date'], event['time'], likes, event['venue'], event['type'], event['id']);
        events.add(curr);
      }
      context.read<Subscriptions>().setEvents(events);
    });
  }

  Future<void> getRideDetails(BuildContext context) async {
    await http.post(Uri.parse("${uri}db/rideStatus/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": widget.email,
        })).then((value) {
      var data = jsonDecode(value.body);
      String status = data['status'];
      if(status != "N/A"){
        if(!data['completed']){
          RideObject ride = RideObject();
          ride.setRide(data["status"], data["reg"], data["carName"], data["driver"], data["from"], data["to"], data["completed"]);
          context.read<Subscriptions>().setRide(ride);
          context.read<Subscriptions>().setBooked(true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xff003b5c),
        ),
      ),
    );
  }

  void setDailyNotifications() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isDailyNotified = sharedPreferences.getBool('isDailyNotified');

    print(isDailyNotified);
    if(isDailyNotified == null){
      Time breakfastTime = const Time(17, 10, 0);
      Time lunchTime = const Time(17, 25, 0);
      Time dinnerTime = const Time(17, 40, 0);

      pushNotification.dailyNotification(id: 0, title: "Wits Dining", body: "Time to collect breakfast", time: breakfastTime);
      pushNotification.dailyNotification(id: 1, title: "Wits Dining", body: "Time to collect lunch", time: lunchTime);
      pushNotification.dailyNotification(id: 2, title: "Wits Dining", body: "Time to collect dinner", time: dinnerTime);

      sharedPreferences.setBool('isDailyNotified', true);
      debugPrint("User will be notified daily now...");
    }

    sharedPreferences.remove('isDailyNotified');


  }
}
