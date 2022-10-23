library globals;

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'Booking.dart';
import 'package:sdp_wits_services/globals.dart' as globals;

String url = "https://sdpwitsservices-production.up.railway.app";

List<Booking> AllBookings = [
  // Booking(type: "all", obj: {
  //   "creator": "",
  //   "time": "",
  //   "date": "",
  //   "counsellor": "",
  //   "counsellorName": "",
  //   "description": "bhiy",
  //   "location": "Online"
  // }),
  // Booking(type: "all", obj: {
  //   "creator": "",
  //   "time": "",
  //   "date": "",
  //   "counsellor": "",
  //   "counsellorName": "",
  //   "description": "vyih",
  //   "location": "Online"
  // }),
  // Booking(type: "all", obj: {
  //   "creator": "",
  //   "time": "",
  //   "date": "",
  //   "counsellor": "",
  //   "counsellorName": "",
  //   "description": "o",
  //   "location": "inPerson"
  // }),
];
List<Booking> AcceptedBookings = [];

Future<void> GetAllBookings() async {
  debugPrint("kkkkkkkkkkk");
  http.Response result =
      await http.post(Uri.parse("$url/ccdu/addPendingAppointments"),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(<String, dynamic>{"email": globals.email}));
  List myList = jsonDecode(result.body);
  AllBookings.clear();
  for (int i = 0; i < myList.length; i++) {
    AllBookings.add(Booking(obj: myList[i], type: 'all'));
  }
  //debugPrint(globals.email);
}

Future<void> GetAcceptedBookings() async {
  debugPrint("kkkkkkkkkkk");
  http.Response result =
      await http.post(Uri.parse("$url/ccdu/allAcceptedAppointments"),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(<String, dynamic>{"email": globals.email}));
  List myList = jsonDecode(result.body);
  debugPrint('$myList.length');
  AcceptedBookings.clear();
  for (int i = 0; i < myList.length; i++) {
    AcceptedBookings.add(Booking(obj: myList[i], type: 'all'));
  }
  //debugPrint(globals.email);
}

Future<void> HandleBooking(Booking booking) async {
  //debugPrint(globals.email);
}
