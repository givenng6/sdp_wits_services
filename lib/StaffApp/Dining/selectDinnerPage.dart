import 'package:flutter/material.dart';
import 'AccordionWidget.dart';

//Diner tab

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
    return const Scaffold(
      body: AccordionWidget(type: "dinner"),
    );
  }
}
