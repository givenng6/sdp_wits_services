import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusSchedule.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';
import './BusObject.dart';

class Buses extends HookWidget {
  // shared class with common utilities...
  UtilityWidget utilityWidget = UtilityWidget();

  // global variables to be used on the widgets...
  String title = "Bus Services";
  String email = "";
  String service = "bus_service";
  List<String> data = [];

  // variables for testing...
  var nBusSchedule = [];
  var nSubs = [];
  var nBusFollowing = [];

  // data variables for the widget...
  var busSchedule = useState([]);
  var subs = useState([]);
  var busFollowing = useState([]);

  // constructor...
  // data init...
  Buses(this.email, this.nSubs, this.nBusSchedule, this.nBusFollowing, {Key? key})
      : super(key: key) {
    data = [email, title, service];
    subs.value = nSubs;
    busSchedule.value = nBusSchedule;
    busFollowing.value = nBusFollowing;
  }

  @override
  Widget build(BuildContext context) {
    // variable that checks if the user is subscribed for the service..
    var isSubscribed = useState(false);

    List<BusObject> busSchedule2 = [];

    // change is sub to true if the user is sub to bus services...
    if (subs.value.contains(service)) {
      isSubscribed.value = true;
    }

    // copying data from the hooks to the actual built in list...
    for (BusObject data in busSchedule.value) {
      busSchedule2.add(data);
    }

    return Scaffold(
      // conditional rendering
      // if sub show the actual bus routes
      // else show the sub page
      body: isSubscribed.value
          ? SingleChildScrollView(
              child: Column(
                children: [
                  utilityWidget.AppBar(title),
                  BusSchedule(email, busSchedule2, busFollowing)
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddSub(isSubscribed, data, subs),
              ],
            ),
    );
  }
}
