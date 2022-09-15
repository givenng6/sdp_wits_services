import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/SudentsApp/Dining/DiningCard.dart';
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
  Dining(this.email, this.subs, {Key? key}) : super(key: key){
    data = [email, title, service];
  }

  @override
  Widget build(BuildContext context) {

    if(subs.value.contains(service)){
      isSubscribed.value = true;
    }

    return Scaffold(
      body: isSubscribed.value ?  Column(
        children: [
          utilityWidget.AppBar(title),
          DiningCard()
        ],
      ) :
      Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          AddSub(isSubscribed, data, subs),
        ],
      ),
    );
  }
}
