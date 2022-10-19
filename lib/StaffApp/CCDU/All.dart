// import 'dart:html';

import 'package:flutter/material.dart';
import 'Booking.dart';
import 'ccduGlobals.dart' as localGlobals;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  State<All> createState() => AllState();
}

class AllState extends State<All> {
  // TODO fil the bookings array with data from the database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: makeList()
        )
    );
  }

  Widget makeList() {

    return Column(
      children: localGlobals.AllBookings.map((booking) => _card(booking)).toList(),
    );


  }

  Widget _card(Booking booking) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Name: ${booking.name}"),
            Text("Email: ${booking.email}"),
            Text("Date: ${booking.date}"),
            Text("Time: ${booking.time}"),
            Text("Description"),
            Text(booking.description),
            if(booking.type == "")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                     localGlobals.HnadleBooking(booking);
                    },
                    child: Text('ACCEPT')),
              ],
            )
          ],
        ),
        // style: TextStyle(fontSize: 16),),
      ),
    );
  }
}
