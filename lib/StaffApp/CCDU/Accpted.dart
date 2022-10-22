// import 'dart:html';
import 'Booking.dart';
import 'ccduGlobals.dart' as localGlobals;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';

class Accepted extends StatefulWidget {
  const Accepted({Key? key}) : super(key: key);

  @override
  State<Accepted> createState() => AcceptedState();
}

class AcceptedState extends State<Accepted> {
  Future<void> init() async {
    await localGlobals.GetAcceptedBookings();
    setState(() {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: makeList()));
  }

  Widget makeList() {
    return Column(
      children: localGlobals.AcceptedBookings.map((booking) => _card(booking))
          .toList(),
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
            Text("Date: ${booking.date}"),
            Text("Time: ${booking.time}"),
            Text("Description"),
            Text(booking.description),
          ]),
    ));
  }
}
