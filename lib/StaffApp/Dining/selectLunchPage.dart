import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AccordionWidget.dart';
import 'Package.dart';

class selectLunchPage extends StatefulWidget {
  final DateTime dateTime;
  selectLunchPage({
    Key? key,
    required this.dateTime
  }) : super(key: key);

  @override
  State<selectLunchPage> createState() => _selectLunchPageState();
}

class _selectLunchPageState extends State<selectLunchPage> {
  @override

  Widget build(BuildContext context) {
    return const Scaffold(
      body: AccordionWidget(type: "lunch"),
    );
  }
}