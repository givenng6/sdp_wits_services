import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class Dining extends StatefulWidget{
  const Dining({Key? key}) : super(key: key);

  @override
  State<Dining> createState() => _Dining();
}

class _Dining extends State<Dining>{
  UtilityWidget utilityWidget = new UtilityWidget();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  Column(
        children: [
        utilityWidget.AppBar("Dining Services"),
        ],
      ),
    );
  }
}