library globals;

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'Booking.dart';
import 'package:sdp_wits_services/globals.dart' as globals;

String url = "https://sdpwitsservices-production.up.railway.app";

List<Booking> AllBookings = [];
List<Booking> AcceptedBookings = [];

Future<void> GetAllBookings() async {
  debugPrint("Called All bookings");
  http.Response result =
      await http.post(Uri.parse("$url/ccdu/allPendingAppointments"),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(<String, dynamic>{"email": globals.email}));
  List myList = await jsonDecode(result.body).toList();

  debugPrint("list: $myList");

  AllBookings.clear();
  for (int i = 0; i < myList.length; i++) {
    AllBookings.add(Booking(type: 'all',obj: myList[i],));
  }

}

Future<void> GetAcceptedBookings() async {
  http.Response result =
      await http.post(Uri.parse("$url/ccdu/allAcceptedAppointments"),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(<String, dynamic>{"email": globals.email}));
  List myList = await jsonDecode(result.body).toList();
  AcceptedBookings.clear();
  for (int i = 0; i < myList.length; i++) {
    AcceptedBookings.add(Booking(obj: myList[i], type: 'accepted'));
  }

}

Future<String> HandleBooking(Booking booking) async {
  Map<String,dynamic> info ;
  if(booking.location=="Online"){
    info = {
      "id":booking.id,
      "counsellor":globals.email,
      "counsellorName":globals.username,
      "link":booking.link
    };
  }else{
    info = {
      "id":booking.id,
      "counsellor":globals.email,
      "counsellorName":globals.username,
    };
  }

  http.Response result =
  await http.post(Uri.parse("$url/ccdu/acceptAppointment"),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(info));

  debugPrint("Res: ${result.body}");
  return result.body;



}
