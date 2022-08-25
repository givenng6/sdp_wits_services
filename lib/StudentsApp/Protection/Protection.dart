import 'package:flutter/material.dart';
import '../UtilityWidgets.dart';

class Protection extends StatefulWidget{
  const Protection({Key? key}) : super(key: key);

  @override
  State<Protection> createState() => _Protection();
}

class _Protection extends State<Protection>{
  UtilityWidget utilityWidget = new UtilityWidget();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  Column(
        children: [
          utilityWidget.AppBar("Campus Control"),
        ],
      ),
    );
  }
}