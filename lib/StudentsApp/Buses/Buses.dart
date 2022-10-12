import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusSchedule.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';
import './BusObject.dart';

class Buses extends StatefulWidget{
  final bool? isTesting;
  final List<BusObject>? busSchedule;
  const Buses({super.key, this.isTesting, this.busSchedule});

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

  bool isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    set(){
      context.read<Subscriptions>().addSub(service);
      context.read<Subscriptions>().setBusSchedule(widget.busSchedule!);
    }
    setForTesting()async{
      if(widget.isTesting != null){
        await Future.delayed(const Duration(seconds: 2));
        set();
      }
    }
    setForTesting();


    debugPrint(context.toString());
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
                AddSub(title: title, service: service, isSubscribed: isSubscribed, setSubscribed: setSubscribed),
              ],
            ),
    );
  }
  void setSubscribed(){
    setState(() {
      isSubscribed = true;
    });
  }
}
