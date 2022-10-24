import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/ride_object.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Events/events_object.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/PushNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../StaffApp/Events/Controllers/events_controller.dart';
import '../Buses/BusObject.dart';
import '../Dining/DiningObject.dart';
import './DashAppBar.dart';
import './Widgets/BusWidget.dart';
import './Widgets/DiningWidget.dart';
import './Widgets/ProtectionWidget.dart';
import './Widgets/EventsWidget.dart';
import './Widgets/HealthWidget.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

// Uri to the API
String uri = "https://web-production-a9a8.up.railway.app/";

class Dashboard extends StatefulWidget {
  final bool? isTesting;
  final List<BusObject>? busSchedule;
  final List<String>? busFollowing;
  final String? dhFollowing;
  final String? mealTime;
  final List<DiningObject>? diningHalls;

  const Dashboard({
    super.key,
    this.isTesting,
    this.busSchedule,
    this.busFollowing,
    this.dhFollowing,
    this.diningHalls, this.mealTime,
  });

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final eventsController = Get.find<EventsController>();
  // list of dashboard widgets to show to user...
  final List<Widget> _cards = [];
  String email = "";
  List<String> subs = [];
  bool initRun = true;

  late final PushNotification pushNotification;

  @override
  void initState(){
    pushNotification = PushNotification();
    pushNotification.initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    email = context.watch<UserData>().email;
    set(){
      context.read<Subscriptions>().addSub('bus_service');
      context.read<Subscriptions>().addSub('dining_service');
      context.read<Subscriptions>().addSub('campus_control');
      context.read<Subscriptions>().addSub('health');
      context.read<Subscriptions>().setBusSchedule(widget.busSchedule!);
      context.read<Subscriptions>().updateBusFollowing(widget.busFollowing!);
      context.read<Subscriptions>().updateDHFollowing(widget.dhFollowing!);
      context.read<Subscriptions>().setMealTime(widget.mealTime!);
      context.read<Subscriptions>().setDiningHalls(widget.diningHalls!);
    }
    setForTesting() async {
      await Future.delayed(const Duration(seconds: 1));
      set();
    }

    if (widget.isTesting != null) {
      setForTesting();
    }
    subs = context.watch<Subscriptions>().subs;

    // display all the widgets for the services sub to..
    if(initRun){
    for (String service in subs) {
      switch (service) {
        case 'bus_service':
          _cards.add(BusWidget());
          break;
        case 'dining_service':
          _cards.add(DiningWidget());
          break;
        case 'campus_control':
          _cards.add(ProtectionWidget());
          break;
        case 'events':
          _cards.add(EventsWidget());
          break;
        case 'health':
          _cards.add(HealthWidget());
          break;
      }
    }
    }

    Future onRefresh() async{
      print("Refresh");
      setState(() {
        initRun = false;
      });
      context.read<Subscriptions>().refreshAll();
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
    }

    // conditional rendering
    // show loading view if the data is not ready yet...
    return Scaffold(
      body: Column(
        children: [
          const DashAppBar(),
          DashHeader(),
          Expanded(
            child: _cards.isEmpty
                ? const Center(
                    child: Text(
                      "Dashboard empty",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  )
                : RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                  itemCount: _cards.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _cards[index];
                  }),
            )
          )
        ],
      ),
    );
  }

  Widget DashHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Suggestions:"),
          //Text("My Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SuggestedItem("Campus Health"),
              SuggestedItem("Events"),
              SuggestedItem("CCDU")
            ],
          )
        ],
      ),
    );
  }

  Widget SuggestedItem(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: const Color(0xff003b5c),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          _getIcon(title),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white))
        ],
      ),
    );
  }

  // return icon base on title...
  Widget _getIcon(String title) {
    switch (title) {
      case 'Campus Health':
        return const Icon(
          Icons.health_and_safety,
          color: Colors.red,
          size: 19,
        );
      case 'Events':
        return const Icon(
          Icons.event,
          color: Colors.white,
          size: 19,
        );
      case 'CCDU':
        return const Icon(
          Icons.health_and_safety_outlined,
          color: Colors.green,
          size: 19,
        );
      default:
        return const Icon(
          Icons.home,
          color: Colors.white,
          size: 19,
          key: Key('HomeIcon'),
        );
    }
  }

  Future<void> getSubs(BuildContext context) async {
    await http
        .post(Uri.parse("${uri}db/getSub/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
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
          "email": email,
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
    await http
        .get(Uri.parse("${uri}db/getBusSchedule/"), headers: <String, String>{
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
          "email": email,
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
    await http
        .post(Uri.parse("${uri}db/getBookingCCDU/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{
          "email": email,
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

        if(!scheduledEvents!.contains(id) && date == dateNow && status == 'Confirmed'){
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
        EventObject curr = EventObject(event['title'], event['date'], event['time'], likes, event['venue'], event['type'], event['id'], event['imageUrl']);
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
          "email": email,
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

}
