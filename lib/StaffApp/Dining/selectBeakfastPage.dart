import 'package:flutter/material.dart';
import 'AccordionWidget.dart';

//Breakfast tab

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
    return const Scaffold(
      body: AccordionWidget(type: "breakfast"),
    );
  }
}
