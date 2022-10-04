import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningCard.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';

class Dining extends StatefulWidget{

  @override
  State<Dining> createState() => _Dining();
}

class _Dining extends State<Dining> {
  // shared class with common utilities...
  UtilityWidget utilityWidget = UtilityWidget();

  String title = "Dining Services";
  String email = "";
  String service = "dining_service";
  List<String> data = [];

  // data variables for the widget...
  List<String> subs = [];

  // variable that checks if the user is subscribed for the service..
  bool isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    subs = context.watch<Subscriptions>().subs;
    // change is sub to true if the user is sub to dining services...
    if (subs.contains(service)) {
      setState(() {
        isSubscribed = true;
      });
    }

    return Scaffold(
      // conditional rendering
      // if sub show the actual dining halls
      // else show the sub page
      body: isSubscribed
          ? SingleChildScrollView(
              child: Column(
                children: [
                  utilityWidget.AppBar(title),
                  DiningCard(),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //AddSub(isSubscribed, data, subs),
              ],
            ),
    );
  }
}
