import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusSchedule.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';
import './BusObject.dart';

class Buses extends StatefulWidget{

  @override
  State<Buses> createState() => _Buses();
}

class _Buses extends State<Buses>{
  // shared class with common utilities...
  UtilityWidget utilityWidget = UtilityWidget();

  // global variables to be used on the widgets...
  String title = "Bus Services";
  String email = "";
  String service = "bus_service";
  List<String> data = [];

  // data variables for the widget...
  List<BusObject> busSchedule = [];
  List<String> subs = [];
  List<String> busFollowing = [];

  // constructor...
  // data init...
  _Buses(){

  }

  bool isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    subs = context.watch<Subscriptions>().subs;
    busSchedule = context.watch<Subscriptions>().busSchedule;
    busFollowing = context.watch<Subscriptions>().busFollowing;
    // variable that checks if the user is subscribed for the service..

    // change is sub to true if the user is sub to bus services...
    if (subs.contains(service)) {
      setState(() {
        isSubscribed = true;
      });
    }

    return Scaffold(
      // conditional rendering
      // if sub show the actual bus routes
      // else show the sub page
      body: isSubscribed
          ? SingleChildScrollView(
              child: Column(
                children: [
                  utilityWidget.AppBar(title),
                  BusSchedule()
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ********
                //AddSub(isSubscribed, data, subs),
              ],
            ),
    );
  }
}
