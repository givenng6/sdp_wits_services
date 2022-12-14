library globals;

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'Booking.dart';
import 'package:sdp_wits_services/globals.dart' as globals;

String url = "https://sdpwitsservices-production.up.railway.app";

List<Booking> AllBookings = [];
List<Booking> MyBookings = [];
List<Booking> AcceptedBookings = [];



Future<void> GetAllBookings() async {
  //Fetch all the booking
  http.Response result =
      await http.post(Uri.parse("$url/ccdu/allPendingAppointments"),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(<String, dynamic>{"email": globals.email}));
  List myList = await jsonDecode(result.body).toList();

  AllBookings.clear();
  MyBookings.clear();
  for (int i = 0; i < myList.length; i++) {
    var curr = myList[i];
    if(curr["counsellor"]==globals.email){
      MyBookings.add(Booking(type: 'all',obj: myList[i]));
    }else{
      AllBookings.add(Booking(type: 'all',obj: myList[i]));
    }
  }
}

Future<void> GetAcceptedBookings() async {
  //Fetch all the booking I have accepted
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
  //Accept th booking
  Map<String,dynamic> info; //in person booking don't have a link
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
  //Remove the current booking from the list off all the booking and my booking after it has been accepted.
  AllBookings.remove(booking);
  MyBookings.remove(booking);
  return result.body;
}
