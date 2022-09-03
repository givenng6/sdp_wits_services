import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';

class Buses extends HookWidget {
  UtilityWidget utilityWidget = UtilityWidget();

  var isSubscribed = useState(false);
  String title = "Bus Services";
  String email = "";
  String service = "bus_service";
  List<String> data = [];

  var subs = useState([]);
  Buses(this.email, this.subs, {Key? key}) : super(key: key){
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
