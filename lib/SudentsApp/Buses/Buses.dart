import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class Buses extends StatefulWidget {
  const Buses({Key? key}) : super(key: key);

  @override
  State<Buses> createState() => _Buses();
}

class _Buses extends State<Buses> {
  UtilityWidget utilityWidget = UtilityWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          utilityWidget.AppBar("Bus Services"),
          OutlinedButton(
            child: Text("Press"),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => utilityWidget.BottomSheet());
            },
          )
        ],
      ),
    );
  }
}
