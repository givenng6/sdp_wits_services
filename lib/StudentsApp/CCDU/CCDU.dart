import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/book_appointment.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/CCDU/CCDUObject.dart';

class CCDU extends StatefulWidget {
  const CCDU({super.key});

  @override
  State<CCDU> createState() => _CCDU();
}

class _CCDU extends State<CCDU> {

  List<CCDUObject> sessions = [];

  @override
  Widget build(BuildContext context) {
    sessions = context.watch<Subscriptions>().ccduBookings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CCDU'),
        backgroundColor: const Color(0xff003b5c),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => const BookAppointment());
        },
        backgroundColor: const Color(0xff003b5c),
        icon: const Icon(Icons.add),
        label: const Text('New Session'),
      ),
      body: sessions.isNotEmpty
          ? SingleChildScrollView(
              child: listAppointments(),
            )
          : const Center(
              child: Text('No Data',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey)),
            ),
    );
  }

  Widget listAppointments() {
    List<Widget> items = [];

    int index = 1;
    for (CCDUObject booking in sessions) {
      items.add(appointment(index, booking.date, booking.time,
          booking.counsellorName, booking.status));
      index++;
    }

    return Column(children: items);
  }

  Widget appointment(
      int index, String date, String time, String counsellor, String status) {
    return Card(
        elevation: 3,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Appointment $index",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54)),
              const Text(""),
              Text("Date: $date",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black54)),
              Text("Time: $time",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black54)),
              Text("Counsellor: $counsellor",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black54)),
              status == 'Confirmed'
                  ? Text(status,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green))
                  : Text(status,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange)),
            ],
          ),
        ));
  }
}
