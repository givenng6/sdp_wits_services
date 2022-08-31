import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class Dining extends StatefulWidget {
  const Dining({Key? key}) : super(key: key);

  @override
  State<Dining> createState() => _Dining();
}

class _Dining extends State<Dining> {
  UtilityWidget utilityWidget = new UtilityWidget();

  bool subscribed = false;

  @override
  Widget build(BuildContext context) {
    if(subscribed){
      return Scaffold(
        body: Column(
          children: [
            utilityWidget.AppBar("Dining Services"),
          ],
        ),
      );
    }else{
      return Scaffold(
        body: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [utilityWidget.NotSubscribed("Dining Services", subscribed),]
        ),
      );
    }
  }
}
