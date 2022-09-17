import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AccordionWidget.dart';
import 'Package.dart';

class selectDinnerPage extends StatefulWidget {
  final DateTime dateTime;
  const selectDinnerPage({
    Key? key,
    required this.dateTime
  }) : super(key: key);

  @override
  State<selectDinnerPage> createState() => _selectDinnerPageState();
}

class _selectDinnerPageState extends State<selectDinnerPage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: AccordionWidget(type: "dinner"),
    );
  }
}
