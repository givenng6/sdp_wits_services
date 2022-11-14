import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Providers/Subscriptions.dart';
import '../Providers/UserData.dart';
import '../Utilities/PushNotification.dart';
import 'CCDUObject.dart';

String uri = "https://web-production-a9a8.up.railway.app/";

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  double initialChildSize = 0.6;
  double minChildSize = 0.2;
  double maxChildSize = 0.95;

  String email = "";
  String studentName = "";

  String meetingLocation = 'Online';
  String theCounsellor = '';
  String description = "";

  List<String> places = ['Online', 'In Person'];

  List<String> counsellors = [];
  List<String> counsellorsEmail = [];

  late final PushNotification pushNotification;

  @override
  void initState() {
    pushNotification = PushNotification();
    pushNotification.initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    counsellors = context.watch<Subscriptions>().counsellorsName;
    counsellorsEmail = context.watch<Subscriptions>().counsellorsEmail;
    email = context.watch<UserData>().email;
    studentName = context.watch<UserData>().username;

    DateTime now = DateTime.now();
    String timeNow = DateFormat('kk:mm').format(now);
    String dateNow = DateFormat('dd/MM/yyyy').format(now);
    TimeOfDay time = TimeOfDay(
        hour: int.parse(timeNow.split(":")[0]),
        minute: int.parse(timeNow.split(":")[1]));
    DateTime date = DateTime(int.parse(dateNow.split("/")[2]),
        int.parse(dateNow.split("/")[1]), int.parse(dateNow.split("/")[0]));

    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    if (keyboardIsOpened) {
      initialChildSize = 0.95;
    } else {
      initialChildSize = 0.6;
    }
    // minChildSize = 0.2;
    return makeDismissible(
      child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (_, controller) => StatefulBuilder(
                builder: (_, setState) => Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(0.0))),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    controller: controller,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'New Session',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff003b5c)),
                              onPressed: () async {
                                int newHour = time.hour + 1;
                                String timeFormat =
                                    "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}-${newHour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                                String dateFormat =
                                    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                                await verify(
                                    context,
                                    timeFormat,
                                    dateFormat,
                                    theCounsellor,
                                    description,
                                    meetingLocation,
                                    setState);
                                Get.back();
                              },
                              child: const Text('Submit'),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.event,
                            color: Colors.grey,
                          ),
                          Text("Date"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          TextButton(
                              onPressed: () async {
                                print(int.parse(dateNow.split("/")[2]));
                                DateTime? setDate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(
                                        int.parse(dateNow.split("/")[2]),
                                        int.parse(dateNow.split("/")[1]),
                                        int.parse(dateNow.split("/")[0])),
                                    lastDate: DateTime(2100));

                                if (setDate != null) {
                                  // update the date
                                  setState(() {
                                    date = setDate;
                                  });
                                }
                              },
                              child: const Text('Change Date')),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.watch_later_outlined, color: Colors.grey),
                          Text("Time"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          TextButton(
                              onPressed: () async {
                                TimeOfDay? setTime = await showTimePicker(
                                    context: context, initialTime: time);

                                if (setTime != null) {
                                  // update time
                                  setState(() {
                                    time = setTime;
                                  });
                                }
                              },
                              child: const Text('Change Time')),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.location_pin, color: Colors.grey),
                          Text("Meeting Location"),
                        ],
                      ),
                      DropdownButton(
                          isExpanded: true,
                          value: meetingLocation,
                          items: places.map((String places) {
                            return DropdownMenuItem(
                              value: places,
                              child: Text(places),
                            );
                          }).toList(),
                          onChanged: (String? place) {
                            // must update value
                            setState(() {
                              meetingLocation = place!;
                            });
                          }),
                      Row(
                        children: const [
                          Icon(Icons.person, color: Colors.grey),
                          Text('Choose Counsellor (optional)'),
                        ],
                      ),
                      DropdownButton(
                          key: const Key('Choose Counsellor'),
                          isExpanded: true,
                          value: theCounsellor,
                          items: counsellors.map((String counsellors) {
                            return DropdownMenuItem(
                              value: counsellors,
                              child: Text(counsellors),
                            );
                          }).toList(),
                          onChanged: (String? counsellor) {
                            // must update value
                            setState(() {
                              theCounsellor = counsellor!;
                            });
                          }),
                      Row(
                        children: const [
                          Icon(Icons.add, color: Colors.grey),
                          Text('Add Description'),
                        ],
                      ),
                      TextField(onChanged: (text) {
                        description = text;
                      }),
                      if (keyboardIsOpened)
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                        ),
                    ],
                  ),
                ),
              )),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Future<void> verify(BuildContext context, String time, String date,
      String counsellor, String description, String location, setState) async {
    // validate date...
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 3.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ])),
          );
        });
    await addBooking(context, time, date, setState);
  }

  void onError(BuildContext context, String time) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 3.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      const Text(
                        'Data Validation Failed',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Text(""),
                      Text(
                        "The slot $time is not available",
                        style: const TextStyle(color: Colors.redAccent),
                      )
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    )
                  ],
                )),
          );
        });
  }

  Future<void> addBooking(
      BuildContext context, String time, String date, setState) async {
    String id = "";
    for (int i = 0; i < counsellors.length; i++) {
      if (counsellors[i] == theCounsellor) {
        id = counsellorsEmail[i];
      }
    }
    await http
        .post(Uri.parse("${uri}db/bookingCCDU/"),
            headers: <String, String>{
              "Accept": "application/json",
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode(<String, String>{
              "email": email,
              "studentName": studentName,
              "time": time,
              "date": date,
              "description": description,
              "counsellor": id,
              "counsellorName": theCounsellor,
              "location": meetingLocation,
            }))
        .then((value) {
      // TODO check the returned data if is valid
      var data = jsonDecode(value.body);
      bool? isAvailable = data['status'];

      if (isAvailable != null && isAvailable) {
        pushNotification.scheduleNotification(
            id: 5,
            title: "CCDU Bookings",
            body: "New appointment pending",
            seconds: 1);
        setState(() {
          // add the session to the list...
          CCDUObject session = CCDUObject();
          session.setAppointment(data['id'], 'Pending', time, date, description,
              id, theCounsellor, meetingLocation);
          context.read<Subscriptions>().addCCDUBooking(session);
          // clear all fields..
          theCounsellor = "";
          description = "";

          // remove the dialog
          Navigator.pop(context);
        });
      } else {
        setState(() {
          // remove the dialog
          Navigator.pop(context);

          onError(context, time);
        });
      }
    });
  }
}
