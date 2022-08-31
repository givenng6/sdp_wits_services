import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class Buses extends StatefulWidget {
  const Buses({Key? key}) : super(key: key);

  @override
  State<Buses> createState() => _Buses();
}

class _Buses extends State<Buses> {
  UtilityWidget utilityWidget = UtilityWidget();

  //
  bool subscribed = false;

  @override
  Widget build(BuildContext context) {
    if(subscribed){
      return Scaffold(
        body: Column(
          children: [
            utilityWidget.AppBar("Bus Services"),
          ],
        ),
      );
    }else{
      return Scaffold(
        body: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [utilityWidget.NotSubscribed("Bus Services", subscribed),]
        ),
      );
    }

  }
}
