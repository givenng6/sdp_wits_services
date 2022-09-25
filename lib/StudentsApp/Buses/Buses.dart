import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/BusSchedule.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';
import './BusObject.dart';

class Buses extends HookWidget {
  UtilityWidget utilityWidget = UtilityWidget();

  String title = "Bus Services";
  String email = "";
  String service = "bus_service";
  List<String> data = [];

  var nBusSchedule = [];
  var nSubs = [];
  var nBusFollowing = [];

  var busSchedule = useState([]);
  var subs = useState([]);
  var busFollowing = useState([]);

  Buses(this.email, this.nSubs, this.nBusSchedule, this.nBusFollowing, {Key? key})
      : super(key: key) {
    data = [email, title, service];
    subs.value = nSubs;
    busSchedule.value = nBusSchedule;
    busFollowing.value = nBusFollowing;
  }

  @override
  Widget build(BuildContext context) {
    var isSubscribed = useState(false);

    List<BusObject> busSchedule2 = [];

    if (subs.value.contains(service)) {
      isSubscribed.value = true;
    }

    for (BusObject data in busSchedule.value) {
      busSchedule2.add(data);
    }

    return Scaffold(
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
