// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  TextEditingController linkController = TextEditingController();

  Future<void> init() async {
    await localGlobals.GetAllBookings();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    linkController.text = "";
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: makeList()));
  }

  submit(Booking booking) async {
    booking.setLink(linkController.text);
    localGlobals.HandleBooking(booking);
  }

  void handleOnPressed(Booking booking) async {
    if (booking.location == "Online") {
      showModalBottomSheet(
          context: context,
          builder: (builder) => Container(
                padding: const EdgeInsets.all(15),
                height: 300,
                child: Column(
                  children: [
                    Text("Link"),
                    TextField(
                      controller: linkController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Link',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          submit(booking);
                        },
                        child: Text("Submit"))
                  ],
                ),
              ));
    } else {
      localGlobals.HandleBooking(booking);
    }
  }

  Widget makeList() {
    return ListView.builder(
        itemCount: localGlobals.AllBookings.length,
        itemBuilder: (context, index) =>
            _card(localGlobals.AllBookings[index]));

    return Column(
      children:
          localGlobals.AllBookings.map((booking) => _card(booking)).toList(),
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
            if (booking.type == "all")
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        handleOnPressed(booking);
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
