import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class Buses extends StatefulWidget {
  bool sub;
  Buses({Key? key, required this.sub}) : super(key: key);

  @override
  State<Buses> createState() => _Buses();
}

class _Buses extends State<Buses> {
  UtilityWidget utilityWidget = UtilityWidget();

  //
  bool subscribed = true;

  @override
  Widget build(BuildContext context) {
    if(widget.sub){
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
          children: [utilityWidget.NotSubscribed("Bus Services", widget.sub),]
        ),
      );
    }

  }
}
