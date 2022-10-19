library globals;

import 'Booking.dart';

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

Future<void> GetAllBookings() async {}

Future<void> GetAcceptedBookings() async {}

Future<void> HnadleBooking(Booking booking) async {}
