import 'package:flutter/material.dart';
import 'AccordionWidget.dart';
import 'Package.dart';

class selectBrakefastPage extends StatefulWidget {
  final DateTime dateTime;
  const selectBrakefastPage({
    Key? key,
    required this.dateTime
  }) : super(key: key);

  @override
  State<selectBrakefastPage> createState() => _selectBrakefastPageState();
}

class _selectBrakefastPageState extends State<selectBrakefastPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccordionWidget(type: "breakfast"),
    );
  }
}
