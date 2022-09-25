import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningCard.dart';
import 'package:sdp_wits_services/StudentsApp/Dining/DiningObject.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';

class Dining extends HookWidget {
  UtilityWidget utilityWidget = UtilityWidget();

  String title = "Dining Services";
  String email = "";
  String service = "dining_service";
  List<String> data = [];
  var nSubs = [];
  var nDiningHalls = [];
  var nDhFollowing = '';

  var subs = useState([]);
  var diningHalls = useState([]);
  var dhFollowing = useState("");

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
    var isSubscribed = useState(false);

    List<DiningObject> diningHalls2 = [];

    if (subs.value.contains(service)) {
      isSubscribed.value = true;
    }

    for (DiningObject data in diningHalls.value) {
      diningHalls2.add(data);
    }

    return Scaffold(
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
