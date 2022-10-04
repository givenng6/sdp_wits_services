import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Utilities/AddSub.dart';

class Events extends HookWidget{
  // global variables to be used on the widgets...
  String title = "Events";
  String email = "";
  String service = "events";
  List<String> data = [];

  Events(this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var subs = useState([]);
    var isSubscribed = useState(false);
    data = [email, title, service];

    return Scaffold(
      appBar: AppBar(title: const Text('Events'), backgroundColor: Color(0xff003b5c),),
      body: isSubscribed.value
          ? SingleChildScrollView(
        child: Column(
          children: [
            Text('Sub'),
          ],
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         // AddSub(isSubscribed, data, subs),
        ],
      ),
    );
  }
}