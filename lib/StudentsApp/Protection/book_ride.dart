import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Protection/ride_object.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/PushNotification.dart';
import '../Providers/UserData.dart';

class BookRide extends StatefulWidget {
  const BookRide({Key? key}) : super(key: key);

  @override
  State<BookRide> createState() => _BookRideState();
}

class _BookRideState extends State<BookRide> {
  double initialChildSize = 0.3;
  double minChildSize = 0.2;
  double maxChildSize = 0.95;

  String? from;
  String? to;

  bool isButtonEnabled = true;

  String email = "";
  String username = "";
  late final PushNotification pushNotification;

  @override
  void initState(){
    pushNotification = PushNotification();
    pushNotification.initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    email = context.watch<UserData>().email;
    username = context.watch<UserData>().username;
    return makeDismissible(
      child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (_, controller) => Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20.0))),
                child: ListView(
                  controller: controller,
                  children: [
                    Container(
                      width: 10.0,
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: DropdownButton<String>(
                        focusColor: Colors.black,
                        hint: const Text('From', style: TextStyle(color: Colors.black),),
                        isExpanded: true,
                        value: from,
                        items: context.watch<Subscriptions>().campuses
                            .map((item) => DropdownMenuItem<String>(
                                value: item['campusName'],
                                child: Text(
                                  item['campusName'],
                                  style: const TextStyle(fontSize: 18),
                                )))
                            .toList(),
                        onChanged: (item) => setState(
                          () => from = item.toString(),
                        ),
                      ),
                    ),
                    Container(
                        width: 10.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0.0),
                        child: DropdownButton<String>(
                            hint: const Text('To', style: TextStyle(color: Colors.black),),
                            isExpanded: true,
                            value: to,
                            items: context.watch<Subscriptions>().residences
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      key: Key(item),
                                      style: const TextStyle(fontSize: 18),
                                    )))
                                .toList(),
                            onChanged: (item) =>
                                setState(() => to = item.toString())),
                      ),
                    const SizedBox(height: 30.0,),
                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          top: 30.0, left: 10.0, right: 10.0),
                      child: ElevatedButton(
                        onPressed: isButtonEnabled
                            ? () {
                                if (from != null &&
                                    to != null) {
                                  setState(() {
                                    postButtonChild =
                                        const CircularProgressIndicator();
                                    isButtonEnabled = false;
                                  });
                                  book();
                                }
                              }
                            : null,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Center(
                          child: postButtonChild,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
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

  Widget postButtonChild = const Text(
    'Book',
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  );

  String uri = "https://web-production-8fed.up.railway.app/";

  Future<void> book() async{
    await http.post(Uri.parse("${uri}db/requestRide/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String?>{
          "email": email,
          "username": username,
          "from": from,
          "to": to,
        })
    ).then((value){
      var data = jsonDecode(value.body);
      RideObject ride = RideObject();
      ride.setRide(data["status"], data["reg"], data["carName"], data["driver"], data["from"], data["to"], data["completed"]);
      context.read<Subscriptions>().setRide(ride);
      context.read<Subscriptions>().setBooked(true);
      pushNotification.scheduleNotification(id: 3, title: "Campus Control", body: "Ride has been successfully requested", seconds: 2);
      Navigator.pop(context);
    });
  }
}
