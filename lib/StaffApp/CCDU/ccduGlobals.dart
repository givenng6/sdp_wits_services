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
      await http.post(Uri.parse("$url/ccdu/allPendingAppointments"),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(<String, dynamic>{"email": globals.email}));
  List myList = await jsonDecode(result.body).toList();
  var q = myList.length;
  debugPrint('$q b');

  AcceptedBookings.clear();
  for (int i = 0; i < myList.length; i++) {
    AcceptedBookings.add(Booking(type: 'all',obj: myList[i],));
  }
  var z = AcceptedBookings.length;
  debugPrint('$z bookings');
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
  List myList = await jsonDecode(result.body).toList();
  var r = myList.length;
  debugPrint('$r bookings');
  AcceptedBookings.clear();
  for (int i = 0; i < myList.length; i++) {
    AcceptedBookings.add(Booking(obj: myList[i], type: 'all'));
  }
  //debugPrint(globals.email);
}

Future<void> HandleBooking(Booking booking) async {
  //debugPrint(globals.email);
}
