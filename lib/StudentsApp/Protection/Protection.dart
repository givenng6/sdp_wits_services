import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../UtilityWidgets.dart';
import '../Utilities/AddSub.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';

class Protection extends StatefulWidget{

  @override
  State<Protection> createState() => _Protection();
}

class _Protection extends State<Protection> {
  UtilityWidget utilityWidget = UtilityWidget();

  String title = "Campus Control";
  String email = "";
  String service = "campus_control";
  List<String> data = [];

  List<String> subs = [];
  bool isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    subs = context.watch<Subscriptions>().subs;

    if(subs.contains(service)){
      setState(() {
        isSubscribed = true;
      });
    }

    return Scaffold(
      body: isSubscribed ?  Column(
        children: [
          utilityWidget.AppBar(title),
          /// TO DO: ADD Campus Control here....
        ],
      ) :
      Column(
        mainAxisAlignment:  MainAxisAlignment.center,
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
