import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/SudentsApp/Dining/DiningCard.dart';
import 'package:sdp_wits_services/SudentsApp/Dining/DiningObject.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';

class Dining extends HookWidget {
  UtilityWidget utilityWidget = UtilityWidget();

  var isSubscribed = useState(false);
  String title = "Dining Services";
  String email = "";
  String service = "dining_service";
  List<String> data = [];

  var subs = useState([]);
  var diningHalls = useState([]);
  Dining(this.email, this.subs, this.diningHalls, {Key? key}) : super(key: key){
    data = [email, title, service];
  }

  @override
  Widget build(BuildContext context) {

    List<DiningObject> diningHalls2 = [];

    if(subs.value.contains(service)){
      isSubscribed.value = true;
    }

    for(DiningObject data in diningHalls.value){
      diningHalls2.add(data);
    }

    return Scaffold(
      body: isSubscribed.value ? SingleChildScrollView(
        child:  Column(
          children: [
            utilityWidget.AppBar(title),
            DiningCard(diningHalls2)
          ],
        ),
      )  :
      Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          AddSub(isSubscribed, data, subs),
        ],
      ),
    );
  }
}
