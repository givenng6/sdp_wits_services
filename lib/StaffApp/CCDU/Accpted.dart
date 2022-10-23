// import 'dart:html';
import 'Booking.dart';
import 'ccduGlobals.dart' as localGlobals;
import 'package:flutter/material.dart';

class Accepted extends StatefulWidget {
  const Accepted({Key? key}) : super(key: key);

  @override
  State<Accepted> createState() => AcceptedState();
}

class AcceptedState extends State<Accepted> {
  void init() async {
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
    if(localGlobals.AcceptedBookings.isEmpty){
      return const Center(
        child: Opacity(opacity: 0.9,
        child: Text("No Upcoming Appointments")),
      );
    }else{
      return Column(
        children: localGlobals.AcceptedBookings.map((booking) => _card(booking))
            .toList(),
      );
    }

  }

  Widget _card(Booking booking) {
    return Card(
      elevation: 10,
        child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              booking.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            Text("Date: ${booking.date}"),
            Text("Time: ${booking.time}"),
            Text("Platform: ${booking.location}"),
            if(booking.description!="")const Text("Description"),
            if(booking.description!="")Text(booking.description),
          ]),
    ));
  }
}
