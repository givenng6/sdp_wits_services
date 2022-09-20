import 'package:flutter/material.dart';
import 'AccordionWidget.dart';

class selectLunchPage extends StatefulWidget {
  selectLunchPage({
    Key? key,
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