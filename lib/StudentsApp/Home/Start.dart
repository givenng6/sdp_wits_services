import 'package:flutter/material.dart';
import '../Providers/Subscriptions.dart';
import '../Buses/BusObject.dart';
import '../Dining/DiningObject.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import 'package:sdp_wits_services/StudentsApp/Home/Home.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Uri to the API
String uri = "https://web-production-8fed.up.railway.app/";

class Start extends StatefulWidget {
  String email, username;

  Start({super.key, required this.email, required this.username});

  @override
  State<Start> createState() => _Start();
}

class _Start extends State<Start> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSubs(context);
    getBusFollowing(context);
    getBusSchedule(context);
    getDiningHallFollowing(context);
    getDiningHalls(context);
    getCCDUBookings(context);
    getCounsellors(context);
    getMealTime(context);
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
    await http
        .post(Uri.parse("${uri}db/getBookingCCDU/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": widget.email,
            }))
        .then((value) {
      var data = jsonDecode(value.body);

      for (dynamic object in data) {
        CCDUObject session = CCDUObject();
        session.setAppointment(
            object['status'],
            object['time'],
            object['date'],
            object['description'],
            object['counsellor'],
            object['counsellorName'],
            object['location']);
        context.read<Subscriptions>().addCCDUBooking(session);
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
}
