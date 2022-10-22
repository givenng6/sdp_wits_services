library globals;

import 'package:flutter/cupertino.dart';

import 'Booking.dart';
import 'package:sdp_wits_services/globals.dart' as globals;

List<Booking> AllBookings = [
  Booking(type: "all", obj: {
    "creator": "",
    "time": "",
    "date": "",
    "counsellor": "",
    "counsellorName": "",
    "description": "bhiy",
    "location": "Online"
  }),
  Booking(type: "all", obj: {
    "creator": "",
    "time": "",
    "date": "",
    "counsellor": "",
    "counsellorName": "",
    "description": "vyih",
    "location": "Online"
  }),
  Booking(type: "all", obj: {
    "creator": "",
    "time": "",
    "date": "",
    "counsellor": "",
    "counsellorName": "",
    "description": "o",
    "location": "inPerson"
  }),
];
List<Booking> AcceptedBookings = [];

Future<void> GetAllBookings() async {

  debugPrint(globals.username);
}

Future<void> GetAcceptedBookings() async {}

Future<void> HandleBooking(Booking booking) async {}
