import 'package:flutter/material.dart';
import 'AccordionWidget.dart';

class selectBrakefastPage extends StatefulWidget {
  const selectBrakefastPage({
    Key? key,
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
