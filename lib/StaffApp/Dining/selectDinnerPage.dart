import 'package:flutter/material.dart';
import 'AccordionWidget.dart';

class selectDinnerPage extends StatefulWidget {
  const selectDinnerPage({
    Key? key,
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
