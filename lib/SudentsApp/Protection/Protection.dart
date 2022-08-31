import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class Protection extends StatefulWidget {
  const Protection({Key? key}) : super(key: key);

  @override
  State<Protection> createState() => _Protection();
}

class _Protection extends State<Protection> {
  UtilityWidget utilityWidget = new UtilityWidget();
  bool subscribed = false;
  @override
  Widget build(BuildContext context) {
    if(subscribed){
      return Scaffold(
        body: Column(
          children: [
            utilityWidget.AppBar("Campus Control"),
          ],
        ),
      );
    }else{
      return Scaffold(
        body: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [utilityWidget.NotSubscribed("Campus Control", subscribed),]
        ),
      );
    }
  }
}
