import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningCard.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';

class Dining extends HookWidget {
  // shared class with common utilities...
  UtilityWidget utilityWidget = UtilityWidget();

  String title = "Dining Services";
  String email = "";
  String service = "dining_service";
  List<String> data = [];

  // variables for testing...
  var nSubs = [];
  var nDiningHalls = [];
  var nDhFollowing = '';

  // data variables for the widget...
  var subs = useState([]);
  var diningHalls = useState([]);
  var dhFollowing = useState("");

  // constructor...
  // data init...
  Dining(this.email, this.nSubs, this.nDiningHalls, this.nDhFollowing,
      {Key? key})
      : super(key: key) {
    data = [email, title, service];
    subs.value = nSubs;
    diningHalls.value = nDiningHalls;
    dhFollowing.value = nDhFollowing;
  }

  @override
  Widget build(BuildContext context) {
    // variable that checks if the user is subscribed for the service..
    var isSubscribed = useState(false);

    List<DiningObject> diningHalls2 = [];

    // change is sub to true if the user is sub to dining services...
    if (subs.value.contains(service)) {
      isSubscribed.value = true;
    }

    // copying data from the hooks to the actual built in list...
    for (DiningObject data in diningHalls.value) {
      diningHalls2.add(data);
    }

    return Scaffold(
      // conditional rendering
      // if sub show the actual dining halls
      // else show the sub page
      body: isSubscribed.value
          ? SingleChildScrollView(
              child: Column(
                children: [
                  utilityWidget.AppBar(title),
                  DiningCard(email, diningHalls2, dhFollowing)
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
